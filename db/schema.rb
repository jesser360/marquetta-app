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

ActiveRecord::Schema.define(version: 20170904214208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "product_name"
    t.string "name"
    t.string "start_date"
    t.boolean "active"
    t.string "token"
  end

  create_table "cards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "card_number"
    t.string "token"
    t.integer "last_four"
    t.integer "expiration"
    t.boolean "state"
    t.bigint "user_id"
    t.bigint "card_products_id"
    t.bigint "card_product_id"
    t.index ["card_product_id"], name: "index_cards_on_card_product_id"
    t.index ["card_products_id"], name: "index_cards_on_card_products_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "funding_sources", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "token"
    t.string "account"
    t.boolean "active"
  end

  create_table "funding_transactions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "funding_sources_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount"
    t.string "currency_code"
    t.index ["funding_sources_id"], name: "index_funding_transactions_on_funding_sources_id"
    t.index ["user_id"], name: "index_funding_transactions_on_user_id"
  end

  create_table "fundings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount"
    t.string "currency"
    t.bigint "user_id"
    t.bigint "funding_source_id"
    t.string "token"
    t.index ["funding_source_id"], name: "index_fundings_on_funding_source_id"
    t.index ["user_id"], name: "index_fundings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.string "token"
    t.integer "balance"
  end

  add_foreign_key "cards", "card_products"
  add_foreign_key "cards", "card_products", column: "card_products_id"
  add_foreign_key "cards", "users"
  add_foreign_key "funding_transactions", "funding_sources", column: "funding_sources_id"
  add_foreign_key "funding_transactions", "users"
  add_foreign_key "fundings", "funding_sources"
  add_foreign_key "fundings", "users"
end
