class MailboxesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mailbox, only: [:show, :edit, :update, :destroy]

  layout 'mailbox_layout', only: [:show, :edit]

  def index
    @mailboxes = current_user.mailboxes
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

  private
    def set_mailbox
      @mailbox = current_user.mailboxes.find_by(token: params[:id])
    end

    def mailbox_params
      params.require(:mailbox).permit(:token, :name, :note)
    end
end
