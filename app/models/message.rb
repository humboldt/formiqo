class Message < ApplicationRecord
  belongs_to :mailbox
  validates :email, :body, presence: true
end
