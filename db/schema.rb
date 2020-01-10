# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_09_173938) do

  create_table "event_attendees", force: :cascade do |t|
    t.integer "attended_event_id", null: false
    t.integer "attendee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 2
    t.index ["attended_event_id", "attendee_id"], name: "index_event_attendees_on_attended_event_id_and_attendee_id", unique: true
    t.index ["attended_event_id"], name: "index_event_attendees_on_attended_event_id"
    t.index ["attendee_id"], name: "index_event_attendees_on_attendee_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "address"
    t.date "start_date"
    t.time "start_time"
    t.integer "creator_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_events_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "event_attendees", "events", column: "attended_event_id"
  add_foreign_key "event_attendees", "users", column: "attendee_id"
  add_foreign_key "events", "users", column: "creator_id"
end
