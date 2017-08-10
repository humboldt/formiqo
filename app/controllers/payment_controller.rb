require 'paypal-sdk-rest'

class PaymentController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def execute
    payment = PayPal::SDK::REST::Payment.find(params[:paymentId])

    if payment.execute(payer_id: params[:PayerID])
      current_user.subscription.prolong_for(cookies.signed[:duration])
      clear_stash
      redirect_to root_path, notice: "Subscribed successfully"
    else
      redirect_to root_path, error: "Something went wrong"
    end
  end

  private
    def clear_stash
      cookies.delete(:new_plan_id)
      cookies.delete(:duration)
      cookies.delete(:amount)
    end
end
