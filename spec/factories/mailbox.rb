require 'ffaker'
FactoryGirl.define do
  factory :mailbox do
    name { FFaker::Product.product }
    allowed_fields 'email, message'
    site_url 'www.google.com'
    # user
  end
end
