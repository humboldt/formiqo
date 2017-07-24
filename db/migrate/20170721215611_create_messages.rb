class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :mailbox, foreign_key: true
      t.string :email
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
