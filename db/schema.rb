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

ActiveRecord::Schema[7.0].define(version: 2022_11_01_123715) do
  create_table "artists", force: :cascade do |t|
    t.string "name"
  end

  create_table "artists_events", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "artist_id", null: false
    t.index ["artist_id", "event_id"], name: "index_artists_events_on_artist_id_and_event_id", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.text "description"
    t.datetime "show_date"
    t.string "location"
    t.boolean "is_headliner"
    t.string "name"
  end

  create_table "tickets", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.decimal "amount"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
  end

end
