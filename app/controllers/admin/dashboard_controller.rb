class Admin::DashboardController < Admin::AdminBase
  def index
    @earnings = Subscription.month_earnings.map{|s| s.plan.cost }.sum
  end

  def fetch_data
    @cd = chart_data
    render json: @cd
  end


  def chart_data
    data = []
    mailboxes = Mailbox.joins(:messages).where('messages.created_at BETWEEN ? AND ?', Time.zone.now.beginning_of_day, Time.zone.now).group('mailboxes.id')
    data << mailboxes.map { |mailbox| [mailbox.name, mailbox.user.email] }
    data << mailboxes.map { |mailbox| mailbox.messages.today.length } #size
    data
  end
end
