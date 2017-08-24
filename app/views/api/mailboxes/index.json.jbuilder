json.array! @mailboxes do |mailbox|
  json.token mailbox.token
  json.name mailbox.name
  json.note mailbox.note
  json.created_at mailbox.created_at
  json.url api_mailbox_url(mailbox)
end
