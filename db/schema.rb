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

ActiveRecord::Schema.define(version: 20170526190242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_campaigns", force: :cascade do |t|
    t.integer "platform_id"
    t.integer "company_id"
  end

  create_table "check_in_strategies", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_check_in_strategies_on_name", using: :btree
  end

  create_table "check_ins", force: :cascade do |t|
    t.float    "lat"
    t.float    "lng"
    t.string   "phone_number"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "patron_id"
    t.integer  "store_id"
    t.integer  "check_in_strategy_id"
    t.integer  "resulting_stamp_count"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loyalty_card_terms", force: :cascade do |t|
    t.integer "store_id"
    t.string  "reward_description"
    t.integer "stamps_required"
    t.date    "expiration"
    t.integer "check_in_strategy_id"
  end

  create_table "loyalty_cards", force: :cascade do |t|
    t.integer  "patron_id"
    t.integer  "store_id"
    t.datetime "date_issued"
    t.datetime "date_completed"
    t.integer  "stamps_required"
    t.integer  "stamp_count"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "patron_stores", id: false, force: :cascade do |t|
    t.integer "store_id",  null: false
    t.integer "patron_id", null: false
  end

  create_table "patronage_proofs", force: :cascade do |t|
    t.integer "check_in_id"
    t.integer "patronage_verification_technique_id"
    t.string  "code"
    t.string  "receipt_location"
    t.float   "lat"
    t.float   "lng"
  end

  create_table "patronage_verification_techniques", force: :cascade do |t|
    t.integer "store_id"
    t.string  "description"
  end

  create_table "patrons", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "digit_only_phone_number"
    t.boolean  "pending"
    t.string   "sms_address"
    t.index ["digit_only_phone_number"], name: "index_patrons_on_digit_only_phone_number", using: :btree
  end

  create_table "platforms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "redemption_code_types", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "redemptions", force: :cascade do |t|
    t.integer  "loyalty_card_id"
    t.integer  "redemption_code_type_id"
    t.string   "code"
    t.integer  "store_id"
    t.integer  "patron_id"
    t.boolean  "redeemed"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "is_demo"
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
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "email_for_check_ins"
    t.integer  "redemption_code_type_id"
    t.integer  "company_id"
    t.index ["email_for_check_ins"], name: "index_stores_on_email_for_check_ins", using: :btree
  end

end
