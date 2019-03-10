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

ActiveRecord::Schema.define(version: 2019_03_10_164213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lead_statuses", force: :cascade do |t|
    t.string "name"
    t.integer "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leads", force: :cascade do |t|
    t.string "business_name"
    t.integer "revenue_cents"
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
    t.index ["lead_status_id"], name: "index_leads_on_lead_status_id"
    t.index ["sales_funnel_stage_id"], name: "index_leads_on_sales_funnel_stage_id"
    t.index ["user_id"], name: "index_leads_on_user_id"
  end

  create_table "sales_funnel_stages", force: :cascade do |t|
    t.string "name"
    t.integer "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "leads", "lead_statuses"
  add_foreign_key "leads", "sales_funnel_stages"
  add_foreign_key "leads", "users"
end
