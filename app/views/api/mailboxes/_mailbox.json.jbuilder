json.extract! mailbox, :token, :name, :note, :created_at
json.url api_mailbox_url(mailbox)
json.messages mailbox.messages, :created_at, :message_fields
