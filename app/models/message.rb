class Message < ApplicationRecord
  attr_accessor :comment, :redirect_success, :redirect_fail

  belongs_to :mailbox

  validates :email, :body, presence: true
  validates_length_of :comment, :in => 0..1

  default_scope { order(created_at: :desc) }
end
