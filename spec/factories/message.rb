require 'ffaker'
FactoryGirl.define do
  factory :message do
    message_fields {{email: 'q@q.com', subject: 'lala', body: 'lala'}}
    comment ''
  end
end
