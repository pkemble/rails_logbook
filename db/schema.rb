# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_01_013859) do

  create_table "aircraft", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "tail"
    t.string "ac_model"
    t.boolean "turb", default: false
    t.boolean "multi", default: false
    t.boolean "turboprop", default: false
    t.boolean "efis", default: false
    t.boolean "glass", default: false
    t.boolean "fadec", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_aircraft_on_user_id"
  end

  create_table "airports", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "iata"
    t.string "icao"
    t.integer "elevation"
    t.string "tz"
    t.string "dst"
    t.string "olsontz"
    t.string "country"
    t.float "lat"
    t.float "lon"
    t.integer "used"
    t.string "state"
  end

  create_table "entries", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "pic"
    t.string "crew_name"
    t.integer "crew_meal"
    t.decimal "tips", precision: 8, scale: 2
    t.text "remarks"
    t.string "flight_number"
    t.float "per_diem_hours"
    t.datetime "per_diem_start"
    t.datetime "per_diem_end"
    t.integer "user_id"
    t.decimal "travel_expenses", precision: 8, scale: 2
    t.integer "aircraft_id"
    t.index ["aircraft_id"], name: "index_entries_on_aircraft_id"
  end

  create_table "flights", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.text "dep"
    t.text "arr"
    t.string "blockin"
    t.string "blockout"
    t.integer "entry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "block_time", precision: 8, scale: 1
    t.integer "night_to"
    t.integer "night_ld"
    t.decimal "night", precision: 8, scale: 1
    t.float "instrument"
    t.float "approaches"
    t.boolean "pf"
    t.datetime "p_blockin"
    t.datetime "p_blockout"
    t.integer "user_id"
    t.boolean "globbed", default: false
    t.boolean "xc"
    t.float "distance"
    t.integer "day_ld"
    t.integer "day_to"
    t.boolean "dual_given"
    t.boolean "dual_recvd"
    t.text "remarks"
    t.boolean "marked"
    t.index ["entry_id"], name: "index_flights_on_entry_id"
  end

  create_table "psi_imports", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "dep"
    t.string "arr"
    t.text "tail"
    t.integer "dto"
    t.integer "nto"
    t.integer "dlnd"
    t.integer "night_ld"
    t.decimal "btime", precision: 8, scale: 1
    t.float "ntime"
    t.float "pictime"
    t.float "sictime"
    t.float "melpic"
    t.float "melsic"
    t.integer "holds"
    t.string "pic"
    t.string "sic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "blockout"
    t.string "blockin"
    t.float "approaches"
    t.boolean "imported", default: false
    t.string "ac_model"
    t.datetime "date"
    t.boolean "dual_given"
    t.boolean "dual_recvd"
    t.string "flight_number"
    t.string "import_errors"
  end

  create_table "sessions", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.string "def_flight_number"
    t.boolean "admin", default: false
  end

  add_foreign_key "aircraft", "users"
  add_foreign_key "entries", "aircraft"
  add_foreign_key "flights", "entries"
end
