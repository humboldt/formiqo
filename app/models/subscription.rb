class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  validates_uniqueness_of :user_id, allow_nil: true

  attr_accessor :duration
  validates_presence_of :plan_id

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

  private
    def validate_plan
    end
end
