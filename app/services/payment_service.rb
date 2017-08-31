PayPal::SDK::REST.set_config(
  :mode => ENV['pp_mode'], # "sandbox" or "live"
  :client_id => ENV['pp_client_id'],
  :client_secret => ENV['pp_client_secret'])

class PaymentService
  def initialize(host, amount)
    @payment = PayPal::SDK::REST::Payment.new(data(host, amount))
  end

  def accept
    @payment.create
  end

  def response
    @payment
  end

  def data(host, amount)
    {
      intent: 'sale',
      payer: {
        payment_method: 'paypal' },
      redirect_urls: {
        return_url: host + "/execute",
        cancel_url: host + "/" },
      transactions: [ {
        amount: {
          total: amount,
          currency: 'USD' },
        description: 'formiqo - subscription to plan' } ]
    }
  end
end
