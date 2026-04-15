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

ActiveRecord::Schema[8.1].define(version: 2026_04_15_104617) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "apis", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.string "url", null: false
  end

  create_table "health_checks", force: :cascade do |t|
    t.bigint "api_id", null: false
    t.datetime "checked_at"
    t.datetime "created_at", null: false
    t.float "response_time"
    t.string "status"
    t.integer "status_code"
    t.datetime "updated_at", null: false
    t.index ["api_id"], name: "index_health_checks_on_api_id"
  end

  add_foreign_key "health_checks", "apis"
end
