class User < ApplicationRecord
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
end
