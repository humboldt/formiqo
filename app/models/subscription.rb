class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  validates_uniqueness_of :user_id, allow_nil: true

  attr_accessor :duration
  validates_presence_of :plan_id

  def prolong_for(n)
    update!(end_date: DateTime.now + n.months)
  end

  def change_plan(new_plan_id)
    return if new_plan_id == plan_id
    update!(plan_id: new_plan_id)
  end

  private
    def validate_plan
    end
end
