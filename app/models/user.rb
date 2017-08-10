class User < ApplicationRecord
  after_create :add_subscription

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :mailboxes, dependent: :destroy
  has_one :subscription
  has_one :plan, through: :subscriptions


  def remember_me
    true
  end

  private
  def add_subscription
    Subscription.create(plan_id: 1, user_id: id, end_date: Time.zone.now + 1.day)
  end
end
