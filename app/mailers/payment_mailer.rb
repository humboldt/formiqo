class PaymentMailer < ApplicationMailer
  default from: 'noreply@formiqo.com'

  def prolonged(user, period)
    @user = user
    @period = period
    mail(to: @user.email, subject: 'You subscription was prolonged')
  end
end
