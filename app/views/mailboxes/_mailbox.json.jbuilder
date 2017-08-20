json.extract! mailbox, :token, :name, :note, :created_at
json.url mailbox_url(mailbox, format: :json)
json.messages mailbox.messages, :created_at, :message_fields
