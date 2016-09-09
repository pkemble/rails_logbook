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

ActiveRecord::Schema.define(version: 20160828125112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airports", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "country"
    t.string   "iata"
    t.string   "icao"
    t.integer  "lat"
    t.integer  "lon"
    t.integer  "elev"
    t.string   "tz"
    t.string   "dst"
    t.string   "olsontz"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entries", force: :cascade do |t|
    t.datetime "date"
    t.text     "tail"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "pic"
    t.string   "crew_name"
    t.integer  "crew_meal"
    t.decimal  "tips",            precision: 8, scale: 2
    t.text     "remarks"
    t.string   "flight_number"
    t.float    "per_diem_hours"
    t.datetime "per_diem_start"
    t.datetime "per_diem_end"
    t.integer  "user_id"
    t.decimal  "travel_expenses", precision: 8, scale: 2
    t.string   "ac_model"
  end

  create_table "flights", force: :cascade do |t|
    t.text     "dep"
    t.text     "arr"
    t.string   "blockin"
    t.string   "blockout"
    t.integer  "entry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "block_time"
    t.boolean  "night_to"
    t.boolean  "night_ld"
    t.float    "night"
    t.float    "instrument"
    t.float    "approaches"
    t.boolean  "pf"
    t.datetime "p_blockin"
    t.datetime "p_blockout"
    t.integer  "user_id"
  end

  add_index "flights", ["entry_id"], name: "index_flights_on_entry_id", using: :btree

  create_table "import_exports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "psi_imports", force: :cascade do |t|
    t.string   "date"
    t.string   "dep"
    t.string   "arr"
    t.text     "tail"
    t.integer  "dto"
    t.integer  "nto"
    t.integer  "dlnd"
    t.integer  "night_ld"
    t.float    "btime"
    t.float    "ntime"
    t.float    "pictime"
    t.float    "sictime"
    t.float    "melpic"
    t.float    "melsic"
    t.integer  "holds"
    t.string   "pic"
    t.string   "sic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "blockout"
    t.string   "blockin"
    t.float    "approaches"
    t.boolean  "imported"
    t.string   "ac_model"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "def_tail_number"
    t.string   "def_flight_number"
    t.float    "total_time"
    t.float    "night_curr"
  end

  add_foreign_key "flights", "entries"
end
