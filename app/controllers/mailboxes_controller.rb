class MailboxesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mailbox, only: [:show, :edit, :update, :destroy, :clear_messages]
  layout 'mailbox_layout', only: [:show, :edit]
  load_and_authorize_resource

  def index
    @mailboxes = current_user.mailboxes
    @today, @month, @week, @all_time = 0, 0, 0, 0
    @mailboxes.each do |mailbox|
      @today += mailbox.messages.today.length
      @month += mailbox.messages.week.length
      @week += mailbox.messages.month.length
      @all_time += mailbox.messages.length
    end

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
    unless mailbox_limit_reached
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
    def mailbox_limit_reached
      if current_user.mailboxes.length > current_user.subscription.plan.n_mailboxes
        redirect_to root_path, notice: "Upgrade your plan to add more mailboxes!"
        true
      end
    end

    def set_mailbox
      @mailbox = current_user.mailboxes.find_by(token: params[:id])
    end

    def mailbox_params
      params.require(:mailbox).permit(:token, :site_url, :name, :note, :allowed_fields)
    end
end
