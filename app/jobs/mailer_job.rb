class MailerJob
  include SuckerPunch::Job

  def perform(message)
    MailboxMailer.reply(message).deliver
  end
end
