require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # let(:user1) { FactoryGirl.build(:user) }
  describe "when user signs up" do
    before(:each) do
      Plan.create(name: "Plan 1", description: "3 mailboxes", cost: 4.99, n_mailboxes: 3)
      @user = FactoryGirl.build(:user)
      @user.save! && @user.reload
    end

    it "creates a new subscription and a demo mailbox" do
      expect(@user.subscription).to be_present
      expect(@user.mailboxes.first).to be_present
    end

  end
end
