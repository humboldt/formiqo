class MailboxesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mailbox, only: [:show, :edit, :update, :destroy, :clear_messages]
  layout 'mailbox_layout', only: [:show, :edit]
  load_and_authorize_resource

  def index
    @mailboxes = current_user.mailboxes

    @today = current_user.messages.today.size
    @week = current_user.messages.week.size
    @month = current_user.messages.month.size
    @all_time = current_user.messages.size
  end

  def show
  end

  def new
    @mailbox = Mailbox.new
  end

  def edit
  end

  def create
    @mailbox = current_user.mailboxes.build(mailbox_params)
      respond_to do |format|
        if @mailbox.save
          format.html { redirect_to @mailbox, notice: 'Mailbox was successfully created.' }
          format.json { render :show, status: :created, location: @mailbox }
        else
          format.html { render :new }
          format.json { render json: @mailbox.errors, status: :unprocessable_entity }
        end
      end
  end

  def update
    respond_to do |format|
      if @mailbox.update(mailbox_params)
        format.html { redirect_to @mailbox, notice: 'Mailbox was successfully updated.' }
        format.json { render :show, status: :ok, location: @mailbox }
      else
        format.html { render :edit }
        format.json { render json: @mailbox.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mailbox.destroy
    respond_to do |format|
      format.html { redirect_to mailboxes_url, notice: 'Mailbox was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def clear_messages
    messages = @mailbox.messages
    messages.destroy_all unless messages.nil?
    redirect_to @mailbox, notice: 'Messages were successfully deleted.'
  end

  private
    def set_mailbox
      @mailbox = current_user.mailboxes.find_by(token: params[:id])
    end

    def mailbox_params
      params.require(:mailbox).permit(:token, :site_url, :name, :note, :allowed_fields, :should_reply, :reply_body)
    end
end
