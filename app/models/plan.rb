class Plan < ApplicationRecord
  has_many :subscriptions
  has_many :users, through: :subscriptions
  RANGE = [1,2,3,6].freeze
end
