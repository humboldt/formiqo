# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'ffaker'

3.times.each do |mailbox|
  Mailbox.create(
    user_id: 1,
    site_url: "www.example.com",
    token: Digest::SHA1.hexdigest([Time.now, rand].join),
    name: FFaker::CheesyLingo.title,
    note: FFaker::CheesyLingo.sentence
  )
end

30.times.each do |message|
  Message.create(
    mailbox_id: rand(1..3),
    message_fields: {
      email: FFaker::Internet.disposable_email,
      subject: FFaker::CheesyLingo.title,
      body: FFaker::CheesyLingo.sentence,
    },
    comment: ""
  )
end


Plan.create(name: "Plan 1", description: "10 mailboxes", cost: 9.99, n_mailboxes: 10)
# Plan.create(name: "Plan 2", description: "10 mailboxes", cost: 9.99, n_mailboxes: 10)
