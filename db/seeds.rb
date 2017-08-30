User.create(email: ENV["user_email"], password: ENV["user_password"], admin: true)
Plan.create(name: "Personal", description: "10 mailboxes", cost: 6.99, n_mailboxes: 10)
