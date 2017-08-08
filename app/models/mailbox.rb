class Mailbox < ApplicationRecord
  before_validation :generate_mailbox_token, on: :create
  # before_validation :set_name
  has_many :messages, dependent: :destroy
  belongs_to :user
  validates :name, :site_url, presence: true, uniqueness: { scope: :user_id }
  validate :allowed_fields_amount

  def to_param
    token
  end

  private
    def generate_mailbox_token
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end

    def set_name
      self.name = "my new form" if name.blank?
    end

    def allowed_fields_amount
      fields = allowed_fields.gsub(" ", "").split(",")
      if fields.length > 10
        errors.add(:allowed_fields, "max 10 fields")
      end
    end
end
