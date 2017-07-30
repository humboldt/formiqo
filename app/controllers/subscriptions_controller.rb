class SubscriptionsController < ApplicationController
  # before_action :set_subscription, only: [:index, :show, :edit, :update, :destroy]

  def index
    @plans = Plan.all
  end

  def create
    redirect_to root_path
  end

  def show
    #code
  end

  private


    def message_params
      params.permit(:user_id, :plan_id, :duration)
    end
end
