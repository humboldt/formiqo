class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  validates_uniqueness_of :user_id, allow_nil: true

  attr_accessor :duration
  validates_presence_of :plan_id

  scope :this_month, -> { where('updated_at BETWEEN ? AND ?', Time.zone.now.beginning_of_month, Time.zone.now) }
  scope :updated, -> { where('updated_at > created_at') }
  scope :active, -> { where('end_date > ?', Time.zone.now) }

  def prolong_for(n)
    if end_date < Time.zone.now
      update!(end_date: Time.zone.now + n.months)
    else
      update!(end_date: end_date + n.months)
    end
  end

  def change_plan(new_plan_id)
    return if new_plan_id == plan_id
    update!(plan_id: new_plan_id)
  end

  def expired?
    end_date < Time.zone.now
  end

  # if user subscribed for more than 1 month
  # and if subscription is not expired
  # it will be summed to this month earnings
  def self.month_earnings
    this_month.updated.active
  end

  private
    def validate_plan
    end
end
