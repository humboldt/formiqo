class CreateMailboxes < ActiveRecord::Migration[5.1]
  def change
    create_table :mailboxes do |t|
      t.string :token
      t.string :name
      t.text :note

      t.timestamps
    end
  end
end
