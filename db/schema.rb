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

ActiveRecord::Schema.define(version: 20160814204804) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "carts_listings", id: false, force: :cascade do |t|
    t.integer "cart_id",    null: false
    t.integer "listing_id", null: false
  end

  create_table "listings", force: :cascade do |t|
    t.integer  "pokemon_id"
    t.integer  "user_id"
    t.integer  "price"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moves", force: :cascade do |t|
    t.string   "name"
    t.string   "move_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string   "name"
    t.integer  "cp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "species_id"
    t.integer  "quick_move_id"
    t.integer  "charge_move_id"
    t.integer  "wishlist_id"
    t.integer  "user_wish_list_id"
  end

  create_table "species", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "species_types", id: false, force: :cascade do |t|
    t.integer "type_id",    null: false
    t.integer "species_id", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_wish_lists", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wallet"
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
