class AddTokenindexToMailbox < ActiveRecord::Migration[5.1]
  def change
    add_index :mailboxes, :token, unique: true
  end
end
