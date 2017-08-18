class MailboxMailer < ApplicationMailer
  add_template_helper ApplicationHelper
  default from: 'noreply@formiqo.com'

  def reply(message)
    @message = message
    @email = @message.message_fields['email']
    return if @email.empty?
    mail(to: @message.message_fields['email'], subject: 'You message was delivered')
  end

  def forward(message, user)
    @message = message
    @user = user
    mail(to: @user.email, subject: 'Forwarding new message')
  end

  def weekly_report(mailbox, user)
    @mailbox = mailbox
    @user = user
    mail(to: @user.email, subject: "You weekly report for #{@mailbox.name}")
  end
end
