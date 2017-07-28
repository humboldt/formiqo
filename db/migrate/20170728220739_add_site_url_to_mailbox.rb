class AddSiteUrlToMailbox < ActiveRecord::Migration[5.1]
  def change
    add_column :mailboxes, :site_url, :string
  end
end
