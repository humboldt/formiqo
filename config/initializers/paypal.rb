<<<<<<< HEAD
PayPal::SDK.load("config/paypal.yml", Rails.env)
=======
PayPal::SDK::Core::Config.load('config/paypal.yml',  ENV['RACK_ENV'] || 'development')
# PayPal::SDK.load("config/paypal.yml", Rails.env)
>>>>>>> 25d7f2c82bd60c97876be9fec657c85bef7b110e
PayPal::SDK.logger = Rails.logger
