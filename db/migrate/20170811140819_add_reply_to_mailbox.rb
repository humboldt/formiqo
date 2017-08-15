class AddReplyToMailbox < ActiveRecord::Migration[5.1]
  def change
    add_column :mailboxes, :should_reply, :boolean, default: false
    add_column :mailboxes, :reply_body, :text
  end
end
