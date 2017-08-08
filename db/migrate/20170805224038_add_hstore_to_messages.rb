class AddHstoreToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :message_fields, :jsonb, null: false, default: '{}'
    add_index :messages, :message_fields, using: :gin
  end
end
