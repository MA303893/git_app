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

ActiveRecord::Schema.define(version: 20171022172932) do

  create_table "applicant_documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "applicant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_applicant_documents_on_applicant_id"
  end

  create_table "applicants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "alt_email"
    t.string "country_of_citizenship"
    t.boolean "other_citizenship"
    t.string "other_citizenship_country"
    t.boolean "eu_passport"
    t.string "country_of_birth"
    t.string "gender"
    t.string "marital_status"
    t.date "dob"
    t.boolean "criminal_convicted"
    t.text "criminal_convicted_value"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "suburb"
    t.string "city"
    t.string "state"
    t.string "postcode"
    t.string "country"
    t.string "phone"
    t.string "skype"
    t.text "link_to_video"
    t.string "emergency_contact_name"
    t.string "emergency_contact_email"
    t.string "emergency_contact_phone"
    t.string "emergency_contact_relation"
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.string "resume_file_name"
    t.string "resume_content_type"
    t.integer "resume_file_size"
    t.datetime "resume_updated_at"
  end

  create_table "applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "job_id"
    t.bigint "applicant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_applications_on_applicant_id"
    t.index ["job_id"], name: "index_applications_on_job_id"
  end

  create_table "dependents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "applicant_id"
    t.string "name"
    t.string "gender"
    t.date "dob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_dependents_on_applicant_id"
  end

  create_table "experiences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "applicant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_experiences_on_applicant_id"
  end

  create_table "jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_jobs_on_school_id"
  end

  create_table "licences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "applicant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_licences_on_applicant_id"
  end

  create_table "qualifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "applicant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_qualifications_on_applicant_id"
  end

  create_table "schools", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: false, null: false
    t.index ["user_id"], name: "index_schools_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "auth_token"
    t.string "user_type"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "applicant_documents", "applicants"
  add_foreign_key "applications", "applicants"
  add_foreign_key "applications", "jobs"
  add_foreign_key "dependents", "applicants"
  add_foreign_key "experiences", "applicants"
  add_foreign_key "licences", "applicants"
  add_foreign_key "qualifications", "applicants"
end
