class Api::MailboxesController < Api::BaseController
  before_action :set_mailbox, only: [:show]
  def index
    @mailboxes = current_user.mailboxes
    render 'api/mailboxes/index.json.jbuilder'
  end

  def show
    render 'api/mailboxes/show.json.jbuilder'
  end


  private
  def set_mailbox
    @mailbox = current_user.mailboxes.find_by(token: params[:id])
    render {} unless @mailbox
  end
end
