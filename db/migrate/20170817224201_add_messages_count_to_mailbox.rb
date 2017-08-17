class AddMessagesCountToMailbox < ActiveRecord::Migration[5.1]
  def change
    add_column :mailboxes, :messages_count, :integer, default: 0
  end
end
