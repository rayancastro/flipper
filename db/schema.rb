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

ActiveRecord::Schema.define(version: 2019_03_14_232925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "user_id"
    t.bigint "contact_id"
    t.bigint "lead_id"
    t.datetime "date"
    t.boolean "done", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_activities_on_contact_id"
    t.index ["lead_id"], name: "index_activities_on_lead_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "position"
    t.bigint "lead_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lead_id"], name: "index_contacts_on_lead_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.integer "total_revenue_cents", default: 0, null: false
    t.string "total_revenue_currency", default: "BRL", null: false
    t.integer "total_mqls"
    t.date "start_date"
    t.date "end_date"
    t.boolean "closed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lead_backlogs", force: :cascade do |t|
    t.bigint "lead_id"
    t.bigint "user_id"
    t.integer "previous_stage_id"
    t.integer "new_stage_id"
    t.integer "revenue_cents", default: 0, null: false
    t.string "revenue_currency", default: "BRL", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lead_id"], name: "index_lead_backlogs_on_lead_id"
    t.index ["user_id"], name: "index_lead_backlogs_on_user_id"
  end

  create_table "lead_statuses", force: :cascade do |t|
    t.string "name"
    t.integer "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leads", force: :cascade do |t|
    t.string "business_name"
    t.date "closure_date"
    t.bigint "user_id"
    t.bigint "sales_funnel_stage_id"
    t.bigint "lead_status_id"
    t.string "website"
    t.string "address"
    t.string "city"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "revenue_cents", default: 0, null: false
    t.index ["lead_status_id"], name: "index_leads_on_lead_status_id"
    t.index ["sales_funnel_stage_id"], name: "index_leads_on_sales_funnel_stage_id"
    t.index ["user_id"], name: "index_leads_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "description"
    t.bigint "user_id"
    t.bigint "lead_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lead_id"], name: "index_notes_on_lead_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "sales_funnel_stages", force: :cascade do |t|
    t.string "name"
    t.integer "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_goals", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "goal_id"
    t.integer "current_revenue_cents", default: 0, null: false
    t.string "current_revenue_currency", default: "BRL", null: false
    t.integer "current_mqls", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_user_goals_on_goal_id"
    t.index ["user_id"], name: "index_user_goals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "admin", default: false, null: false
    t.integer "experience_points", default: 0, null: false
    t.integer "level", default: 1, null: false
    t.boolean "account_manager", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "activities", "contacts"
  add_foreign_key "activities", "leads"
  add_foreign_key "activities", "users"
  add_foreign_key "contacts", "leads"
  add_foreign_key "lead_backlogs", "leads"
  add_foreign_key "lead_backlogs", "users"
  add_foreign_key "leads", "lead_statuses"
  add_foreign_key "leads", "sales_funnel_stages"
  add_foreign_key "leads", "users"
  add_foreign_key "notes", "leads"
  add_foreign_key "notes", "users"
  add_foreign_key "user_goals", "goals"
  add_foreign_key "user_goals", "users"
end
