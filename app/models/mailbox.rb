class Mailbox < ApplicationRecord
  before_validation :generate_mailbox_token, on: :create
  has_many :messages, dependent: :destroy
  belongs_to :user, counter_cache: true
  validates :name, presence: true, uniqueness: { scope: :user_id }
  # validates :site_url, presence: true
  validate :validate_allowed_fields_amount
  validate :validate_mailbox_limit, on: :create
  validates :reply_body, presence: true, if: :should_reply?

  def to_param
    token
  end

  private
    def generate_mailbox_token
      self.token = SecureRandom.hex[0..15] # Digest::SHA1.hexdigest([Time.now, rand].join)[0..15]
      generate_mailbox_token if Mailbox.exists?(token: self.token)
    end

    def validate_allowed_fields_amount
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

    def validate_mailbox_limit
      if user.mailboxes.length > user.plan.n_mailboxes
        errors.add(:number_of_mailboxes, "limit reached")
      end
    end

end
