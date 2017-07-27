class AddUserToMailbox < ActiveRecord::Migration[5.1]
  def change
    add_reference :mailboxes, :user, foreign_key: true
  end
end
