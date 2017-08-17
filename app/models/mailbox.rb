class Mailbox < ApplicationRecord
  before_validation :generate_mailbox_token, on: :create
  has_many :messages, dependent: :destroy
  belongs_to :user
  validates :name, :site_url, presence: true, uniqueness: { scope: :user_id }
  validate :allowed_fields_amount
  validates :reply_body, presence: true, :if => :should_reply?

  def to_param
    token
  end

  private
    def generate_mailbox_token
      self.token = SecureRandom.hex[0..15] # Digest::SHA1.hexdigest([Time.now, rand].join)[0..15]
      generate_mailbox_token if Mailbox.exists?(token: self.token)
    end

    def allowed_fields_amount
      fields = allowed_fields.gsub(" ", "").split(",")
      if fields.length > 10
        errors.add(:allowed_fields, "max 10 fields")
      elsif fields.length < 1
        errors.add(:allowed_fields, "min 1 field")
      end
    end

    def should_reply?
      should_reply == true
    end

end
