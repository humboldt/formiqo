class MessagesController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!, except: :create
  before_action :set_message, only: [:destroy]
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_mailbox
  load_and_authorize_resource
  # load_and_authorize_resource :message, through: :mailbox
  skip_authorize_resource only: :create
  layout 'mailbox_layout', only: [:index]

  def index
    @messages = @mailbox.messages
    @messages = @messages.today if params[:range] == 'today'
    @messages = @messages.week if params[:range] == 'week'
    @messages = @messages.search(params[:q]) if params[:q]

    @messages = Kaminari.paginate_array(@messages).page(params[:page]).per(30)
    respond_to do |format|
      format.html
      format.csv { send_data @messages.to_csv }
    end

  end

  def create
    respond_to do |format|
      fields = @mailbox.allowed_fields.gsub(" ", "").split(",")
      h = {}
      fields.each { |f| h[f] = params[f] }
      attrs = message_params.tap { |p| p["message_fields"] = h }


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
      format.html { redirect_to mailbox_messages_url(@mailbox) }
      format.json { head :no_content }
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def set_mailbox
      by = params[:token] || params[:mailbox_id]

      @mailbox = Mailbox.find_by(token: by)

      redirect_to root_path unless @mailbox
    end

    def message_params
      params.permit(:comment, message_fields: {})
    end
end
