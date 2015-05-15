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

ActiveRecord::Schema.define(version: 20150515111914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "recordings", force: :cascade do |t|
    t.integer  "station_id"
    t.integer  "slots_count"
    t.integer  "bikes_count"
    t.string   "status"
    t.datetime "polled_at"
  end

  add_index "recordings", ["station_id", "polled_at"], name: "index_recordings_on_station_id_and_polled_at", unique: true, using: :btree

  create_table "stations", force: :cascade do |t|
    t.string   "kind"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street_number"
    t.string   "street_name"
    t.integer  "height"
    t.string   "status"
    t.integer  "slots_count"
    t.integer  "bikes_count"
    t.datetime "last_polled_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "stations", ["latitude", "longitude"], name: "index_stations_on_latitude_and_longitude", unique: true, using: :btree

  add_foreign_key "recordings", "stations"
end
