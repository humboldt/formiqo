require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # let(:user1) { FactoryGirl.build(:user) }
  describe "when user signs up" do
    # before { @user = FactoryGirl.build(:user) }
    it "creates a new subscription" do
      Plan.create(name: "Plan 1", description: "3 mailboxes", cost: 4.99, n_mailboxes: 3)
      @user = FactoryGirl.build(:user)
      @user.save! && @user.reload
      expect(@user.subscription).to be_present
    end

    it "creates a demo mailbox" do
      @user = FactoryGirl.build(:user)
      @user.save! && @user.reload
      expect(@user.mailboxes.first).to be_present
    end


  end
end
