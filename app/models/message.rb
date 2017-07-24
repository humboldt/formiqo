class Message < ApplicationRecord
  belongs_to :mailbox
  validates :email, :body, presence: true

  default_scope { order(created_at: :desc) }
end
