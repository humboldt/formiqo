class Mailbox < ApplicationRecord
  before_create :generate_mailbox_token
  has_many :messages, dependent: :destroy
  belongs_to :user
  validates :name, :site_url, presence: true

  def to_param
    token
  end

  private
    def generate_mailbox_token
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end
end
