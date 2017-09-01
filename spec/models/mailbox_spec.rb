require 'rails_helper'

RSpec.describe Mailbox, type: :model do
  describe "mailbox limit" do
    it "should not create more than limited number of mailboxes" do
      Plan.create(name: "Plan 1", description: "10 mailboxes", cost: 6.99, n_mailboxes: 10)
      user = FactoryGirl.create(:user)

      15.times {
        FactoryGirl.build(:mailbox, user_id: user.id).save
      }
      expect(user.mailboxes.count).to eq(10)
    end
  end
end
