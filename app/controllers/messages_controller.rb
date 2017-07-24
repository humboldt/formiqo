class MessagesController < ApplicationController
  # before_action :set_message, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_mailbox

  def index
    @messages = @mailbox.messages
  end

  def create
    @message = @mailbox.messages.create!(message_params)
    redirect_to @mailbox
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def set_mailbox
      if params[:token]
        @mailbox = Mailbox.find_by(token: params[:token])
      else
        @mailbox = Mailbox.find(params[:mailbox_id])
      end
    end

    def message_params
      params.permit(:email, :subject, :body)
    end
end
