class AddAllowedFieldsToMailbox < ActiveRecord::Migration[5.1]
  def change
    add_column :mailboxes, :allowed_fields, :string
  end
end
