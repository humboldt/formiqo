class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  validates_uniqueness_of :user_id, allow_nil: true

  attr_accessor :duration
end
