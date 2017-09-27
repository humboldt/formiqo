require 'rails_helper'

RSpec.describe Mailbox, type: :model do
  describe "mailbox limit" do
    before(:each) do
      Plan.create(name: "Plan 1", description: "10 mailboxes", cost: 6.99, n_mailboxes: 2)
      @user = FactoryGirl.build(:user)
      @user.save! && @user.reload
    end
    it "should not create more than limited number of mailboxes" do




        FactoryGirl.build(:mailbox, user_id: @user.id).save
        FactoryGirl.build(:mailbox, user_id: @user.id).save

      expect(@user.mailboxes.count).to eq(2)
    end
  end
end
