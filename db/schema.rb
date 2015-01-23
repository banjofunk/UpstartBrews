# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150120180418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batch_processes", force: true do |t|
    t.integer  "batch_id"
    t.string   "process_type"
    t.datetime "started"
    t.datetime "stopped"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "batch_readings", force: true do |t|
    t.integer  "batch_id"
    t.float    "ph"
    t.float    "temp"
    t.float    "brix"
    t.datetime "reading_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "batches", force: true do |t|
    t.integer  "flavor_id"
    t.integer  "fermenter_id"
    t.integer  "state"
    t.datetime "brew_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.integer  "commentable_type"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree

  create_table "fermenters", force: true do |t|
    t.integer  "flavor_id"
    t.integer  "position"
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flavors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name",             default: "",   null: false
    t.string   "last_name",              default: "",   null: false
    t.boolean  "active",                 default: true, null: false
    t.integer  "roles_mask",             default: 0
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
