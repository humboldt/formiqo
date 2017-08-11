class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription, only: [:index, :show, :edit, :update, :destroy]

  def index
    @plans = Plan.all
  end

  def show
    #code
  end

  def update
    @new_plan_id = params[:subscription][:plan_id]
    @duration = params[:subscription][:duration]

    if !@new_plan_id.blank? && !@duration.blank?
      if Plan.exists?(id: @new_plan_id)
        @amount = Plan.find(@new_plan_id).cost * @duration.to_f
      end

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
      @subscription = current_user.subscription
    end

    def extract_link(data)
      data.links.find { |link| link.rel == 'approval_url' }.href
    end

    def proceed_payment(amount)
    end

    def stash_details(npid, drt, amnt)
      cookies.signed[:new_plan_id] = npid.to_i
      cookies.signed[:duration] = drt.to_i
      cookies.signed[:amount] = amnt.to_f
    end
end
