require 'paypal-sdk-rest'

PayPal::SDK::REST.set_config(
  :mode => "sandbox", # "sandbox" or "live"
  :client_id => "AXIpompLJuiKlqsFdRZY_zJs8YnlG0VpTM2YZ4nGzIVGwDP58U4LJwLrC55CDJd4Pu6k1u-BvnPFzhH7",
  :client_secret => "EHfeekIlze5OXoJ03X4ZeFbYlkRDC-VuefWVsN_I5GaHTGUtm9Ywpt8GVFar3pBAAFqonGk8qPGojxJq")

class PaymentService
  def initialize(amount)
    @payment = PayPal::SDK::REST::Payment.new(data(amount))
  end

  def accept
    @payment.create
  end

  def response
    @payment
  end

  def data(amount)
    {
      intent: 'sale',
      payer: {
        payment_method: 'paypal' },
      redirect_urls: {
        return_url: "http://localhost:3000/execute",
        cancel_url: "http://localhost:3000/" },
      transactions: [ {
        amount: {
          total: amount,
          currency: 'USD' },
        description: 'formiqo - subscription to plan' } ]
    }
  end
end
