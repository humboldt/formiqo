class MessagesController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :set_message, only: [:destroy]
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_mailbox


  layout 'mailbox_layout', only: [:index]

  def index
    @messages = @mailbox.messages
    @messages = @messages.today if params[:range] == 'today'

    @messages = @messages.search(params[:q]) if params[:q]

    # if params[:q]
    #
    #   fields = @mailbox.allowed_fields.gsub(" ", "").split(",")
    #   fields.each do |f|
    #     @messages.where("message_fields -> :key LIKE :value", key: "#{f}", value: "%#{q}%")
    #   end
    # end



    @messages = Kaminari.paginate_array(@messages).page(params[:page]).per(50)
    respond_to do |format|
      format.html
      format.csv { send_data @mailbox.messages.to_csv }
    end
  end

  def create
    respond_to do |format|
      fields = @mailbox.allowed_fields.gsub(" ", "").split(",")
      h = {}
      fields.each do |f|
        h[f] = params[f]
      end
      attrs = message_params.tap do |p|
        p["message_fields"] = h
      end
      if @mailbox.messages.create(attrs)
        format.html { redirect_to url_link(@mailbox.site_url) }
        format.json { render json: @mailbox }
      else
        format.html { redirect_to url_link(@mailbox.site_url) }
        format.json { render json: @mailbox }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to mailbox_messages_url(@mailbox), notice: 'Message was successfully destroyed.' }
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
        @mailbox = Mailbox.find_by(token: params[:mailbox_id])
      end
      redirect_to root_path unless @mailbox
    end

    def message_params
      params.permit(:comment, message_fields: {})
    end
end
