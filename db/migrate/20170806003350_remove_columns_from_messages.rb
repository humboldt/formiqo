class RemoveColumnsFromMessages < ActiveRecord::Migration[5.1]
  def change
    remove_column :messages, :email
    remove_column :messages, :subject
    remove_column :messages, :body
  end
end
