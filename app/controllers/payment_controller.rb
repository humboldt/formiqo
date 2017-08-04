require 'paypal-sdk-rest'
include PayPal::SDK::REST

class PaymentController < ApplicationController

  def index
  end

  def execute
    payment = Payment.find(params[:paymentId])

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
