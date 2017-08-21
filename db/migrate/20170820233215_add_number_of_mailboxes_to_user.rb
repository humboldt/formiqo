class AddNumberOfMailboxesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :mailboxes_count, :integer, default: 0
  end
end
