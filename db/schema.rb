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

ActiveRecord::Schema[7.2].define(version: 2024_10_13_001434) do
  create_table "courses", force: :cascade do |t|
    t.string "term"
    t.text "dept_code"
    t.string "course_id"
    t.string "sec_coreq_secs"
    t.string "syn"
    t.string "sec_name"
    t.string "short_title"
    t.integer "im"
    t.string "building"
    t.string "room"
    t.string "days"
    t.time "start_time"
    t.time "end_time"
    t.string "fac_id"
    t.string "faculty_name"
    t.integer "crs_capacity"
    t.integer "sec_cap"
    t.integer "student_count"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
