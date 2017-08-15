# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170811140819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mailboxes", force: :cascade do |t|
    t.string "token"
    t.string "name"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "site_url"
    t.string "allowed_fields"
    t.boolean "should_reply", default: false
    t.text "reply_body"
    t.index ["user_id"], name: "index_mailboxes_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "mailbox_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "message_fields", default: "{}", null: false
    t.index ["mailbox_id"], name: "index_messages_on_mailbox_id"
    t.index ["message_fields"], name: "index_messages_on_message_fields", using: :gin
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "cost"
    t.integer "n_mailboxes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "plan_id"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "mailboxes", "users"
  add_foreign_key "messages", "mailboxes"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "users"
end
