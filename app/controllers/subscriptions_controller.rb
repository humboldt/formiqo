class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:index, :show, :edit, :update, :destroy]

  def index
    @plans = Plan.all
  end

  def create
    @new_plan_id = params[:subscription][:plan_id]
    @duration = params[:subscription][:duration]


    if !@new_plan_id.blank? && !@duration.blank?
      @amount = Plan.find(@new_plan_id).cost * @duration.to_f
      @payment = PaymentService.new(@amount)
      if @payment.accept
        stash_details(@new_plan_id, @duration, @amount)
        redirect_to extract_link(@payment.response)
      else
        redirect_to subscriptions_path, notice: "Something went wrong"
      end
    else
      redirect_to subscriptions_path, notice: "Please select plan and duration"
    end
  end

  def show
    #code
  end

  def update
    @new_plan_id = params[:subscription][:plan_id]
    @duration = params[:subscription][:duration]


    if !@new_plan_id.blank? && !@duration.blank?
      @amount = Plan.find(@new_plan_id).cost * @duration.to_f
      @payment = PaymentService.new(@amount)
      if @payment.accept
        stash_details(@new_plan_id, @duration, @amount)
        redirect_to extract_link(@payment.response)
      else
        redirect_to subscriptions_path, notice: "Something went wrong"
      end
    else
      redirect_to subscriptions_path, notice: "Please select plan and duration"
    end
  end

  private
    def message_params
      params.require(:subscription).permit(:user_id, :plan_id, :duration)
    end

    def set_subscription
      @subscription = if current_user.subscription
        current_user.subscription
      else
        current_user.subscription.new
      end
    end

    def extract_link(data)
      data.links.find { |link| link.rel == 'approval_url' }.href
    end



    def stash_details(npid, drt, amnt)
      cookies.signed[:new_plan_id] = npid.to_i
      cookies.signed[:duration] = drt.to_i
      cookies.signed[:amount] = amnt.to_f
    end
end
