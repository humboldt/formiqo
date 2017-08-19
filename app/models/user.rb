class User < ApplicationRecord
  after_create :add_subscription
  after_create :add_mailbox

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :mailboxes, dependent: :destroy
  has_many :messages, through: :mailboxes
  has_one :subscription, dependent: :destroy
  has_one :plan, through: :subscriptions

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates_format_of :email, :with => EMAIL_REGEX

  def remember_me
    true
  end

  def reached_mailbox_limit?
    mailboxes.length > subscription.plan.n_mailboxes
  end

  private
    def add_subscription
      Subscription.create(plan_id: 1, user_id: id, end_date: Time.zone.now + 1.day)
    end

    def add_mailbox
      Mailbox.create(user_id: id,
          name: "Demo mailbox",
          site_url: "formiqo.com",
          note: "Contact form for my blog", allowed_fields: "email, subject, body")
    end
end
