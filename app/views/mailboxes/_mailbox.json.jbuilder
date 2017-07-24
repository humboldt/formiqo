json.extract! mailbox, :id, :token, :name, :note, :created_at, :updated_at
json.url mailbox_url(mailbox, format: :json)
