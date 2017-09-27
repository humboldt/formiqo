require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  describe "create message" do
    before(:each) do
      Plan.create(name: "Plan 1", description: "10 mailboxes", cost: 6.99, n_mailboxes: 10)
      @user = FactoryGirl.create(:user)
      @mailbox = @user.mailboxes.first
    end

    it "creates a message for selected mailbox" do
      message = FactoryGirl.create(:message, mailbox_id: @user.mailboxes.first.id)
      expect(message).to be_valid
      expect(@mailbox.messages).to be_present
    end

    it "redirects to mailbox site url" do
        message = FactoryGirl.attributes_for(:message)
        post :create, params: { message: message, mailbox_id: @user.mailboxes.first.id }
        expect(response).to redirect_to(thank_you_path)
    end
  end
end
