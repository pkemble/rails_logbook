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

ActiveRecord::Schema.define(version: 20151115164110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.datetime "date"
    t.text     "tail"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "pic"
    t.string   "crew_name"
    t.integer  "crew_meal"
    t.decimal  "tips",          precision: 8, scale: 2
    t.text     "remarks"
    t.string   "flight_number"
  end

  create_table "flights", force: :cascade do |t|
    t.text     "dep"
    t.text     "arr"
    t.string   "blockin"
    t.string   "blockout"
    t.integer  "entry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "total_time"
    t.date     "p_blockout"
    t.date     "p_blockin"
  end

  add_index "flights", ["entry_id"], name: "index_flights_on_entry_id", using: :btree

  create_table "widgets", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "flights", "entries"
end
