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

ActiveRecord::Schema.define(version: 20160706201824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exchanges", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "title"
    t.text     "description"
    t.boolean  "secret",       default: false
    t.boolean  "raffled",      default: false
    t.boolean  "exposed",      default: false
    t.integer  "admins",       default: [],                 array: true
    t.integer  "participants", default: [],                 array: true
    t.integer  "invites",      default: [],                 array: true
    t.integer  "requests",     default: [],                 array: true
  end

  create_table "raffles", force: :cascade do |t|
    t.integer  "exchange"
    t.integer  "user"
    t.integer  "gift_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "address_street"
    t.integer  "address_number"
    t.string   "address_aditional"
    t.string   "address_zip"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_country"
    t.text     "about"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
