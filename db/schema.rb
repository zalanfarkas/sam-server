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

ActiveRecord::Schema.define(version: 20180217172135) do

  create_table "attendances", force: :cascade do |t|
    t.integer "student_id"
    t.integer "practical_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practical_id"], name: "index_attendances_on_practical_id"
    t.index ["student_id"], name: "index_attendances_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "sam_course_id"
    t.string "course_title"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sam_course_id"], name: "index_courses_on_sam_course_id", unique: true
    t.index ["staff_id"], name: "index_courses_on_staff_id"
  end

  create_table "demonstrators", force: :cascade do |t|
    t.string "sam_demonstrator_id"
    t.integer "practical_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practical_id"], name: "index_demonstrators_on_practical_id"
    t.index ["sam_demonstrator_id"], name: "index_demonstrators_on_sam_demonstrator_id"
  end

  create_table "enrolments", force: :cascade do |t|
    t.integer "course_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrolments_on_course_id"
    t.index ["student_id"], name: "index_enrolments_on_student_id"
  end

  create_table "practicals", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_practicals_on_course_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "sam_staff_id"
    t.string "first_name"
    t.string "last_name"
    t.string "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_staffs_on_card_id", unique: true
    t.index ["email"], name: "index_staffs_on_email", unique: true
    t.index ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true
    t.index ["sam_staff_id"], name: "index_staffs_on_sam_staff_id", unique: true
    t.index ["unlock_token"], name: "index_staffs_on_unlock_token", unique: true
  end

  create_table "students", force: :cascade do |t|
    t.string "sam_student_id"
    t.string "first_name"
    t.string "last_name"
    t.string "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_students_on_card_id", unique: true
    t.index ["sam_student_id"], name: "index_students_on_sam_student_id", unique: true
  end

end
