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

ActiveRecord::Schema.define(version: 20160826174755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "check_ins", force: :cascade do |t|
    t.float    "lat"
    t.float    "lng"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "patron_id"
    t.integer  "store_id"
  end

  create_table "loyalty_cards", force: :cascade do |t|
    t.integer  "patron_id"
    t.integer  "store_id"
    t.datetime "date_issued"
    t.datetime "date_completed"
    t.integer  "stamp_required"
    t.integer  "stamp_count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "patrons", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "digit_only_phone_number"
  end

  create_table "stamps", force: :cascade do |t|
    t.integer  "loyalty_card_id"
    t.datetime "date_given"
    t.integer  "patron_id"
    t.integer  "store_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "check_in_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
