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

ActiveRecord::Schema.define(version: 20191114154202) do

  create_table "aircraft", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "tail"
    t.string   "ac_model"
    t.boolean  "turb",       default: false
    t.boolean  "multi",      default: false
    t.boolean  "turboprop",  default: false
    t.boolean  "efis",       default: false
    t.boolean  "glass",      default: false
    t.boolean  "fadec",      default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "airports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.string  "city"
    t.string  "iata"
    t.string  "icao"
    t.integer "elevation"
    t.string  "tz"
    t.string  "dst"
    t.string  "olsontz"
    t.string  "country"
    t.float   "lat",       limit: 24
    t.float   "lon",       limit: 24
    t.integer "used"
    t.string  "state"
  end

  create_table "entries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "date"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.boolean  "pic"
    t.string   "crew_name"
    t.integer  "crew_meal"
    t.decimal  "tips",                          precision: 8, scale: 2
    t.text     "remarks",         limit: 65535
    t.string   "flight_number"
    t.float    "per_diem_hours",  limit: 24
    t.datetime "per_diem_start"
    t.datetime "per_diem_end"
    t.integer  "user_id"
    t.decimal  "travel_expenses",               precision: 8, scale: 2
    t.integer  "aircraft_id"
    t.string   "type"
    t.index ["aircraft_id"], name: "index_entries_on_aircraft_id", using: :btree
  end

  create_table "flights", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "dep",        limit: 65535
    t.text     "arr",        limit: 65535
    t.string   "blockin"
    t.string   "blockout"
    t.integer  "entry_id"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.decimal  "block_time",               precision: 8, scale: 1
    t.integer  "night_to"
    t.integer  "night_ld"
    t.decimal  "night",                    precision: 8, scale: 1
    t.float    "instrument", limit: 24
    t.float    "approaches", limit: 24
    t.boolean  "pf"
    t.datetime "p_blockin"
    t.datetime "p_blockout"
    t.integer  "user_id"
    t.boolean  "globbed",                                          default: false
    t.boolean  "xc"
    t.float    "distance",   limit: 24
    t.integer  "day_ld"
    t.integer  "day_to"
    t.boolean  "dual_given"
    t.boolean  "dual_recvd"
    t.text     "remarks",    limit: 65535
    t.boolean  "marked"
    t.index ["entry_id"], name: "index_flights_on_entry_id", using: :btree
  end

  create_table "psi_imports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "dep"
    t.string   "arr"
    t.text     "tail",          limit: 65535
    t.integer  "dto"
    t.integer  "nto"
    t.integer  "dlnd"
    t.integer  "night_ld"
    t.decimal  "btime",                       precision: 8, scale: 1
    t.float    "ntime",         limit: 24
    t.float    "pictime",       limit: 24
    t.float    "sictime",       limit: 24
    t.float    "melpic",        limit: 24
    t.float    "melsic",        limit: 24
    t.integer  "holds"
    t.string   "pic"
    t.string   "sic"
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.string   "blockout"
    t.string   "blockin"
    t.float    "approaches",    limit: 24
    t.boolean  "imported",                                            default: false
    t.string   "ac_model"
    t.datetime "date"
    t.boolean  "dual_given"
    t.boolean  "dual_recvd"
    t.string   "flight_number"
    t.string   "import_errors"
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "session_id",               null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "remember_digest"
    t.string   "def_flight_number"
    t.boolean  "admin",             default: false
  end

  add_foreign_key "entries", "aircraft"
  add_foreign_key "flights", "entries"
end
