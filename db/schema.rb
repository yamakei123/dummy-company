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

ActiveRecord::Schema[7.0].define(version: 2022_10_17_111545) do
  create_table "companies", charset: "utf8mb4", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_groups", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_groups_on_company_id"
    t.index ["group_id"], name: "index_company_groups_on_group_id"
  end

  create_table "group_users", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "name"], name: "index_groups_on_company_id_and_name", unique: true
    t.index ["company_id"], name: "index_groups_on_company_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.integer "age"
    t.bigint "groups_id"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["groups_id"], name: "index_users_on_groups_id"
  end

  add_foreign_key "company_groups", "companies"
  add_foreign_key "company_groups", "groups"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "groups", "companies"
  add_foreign_key "users", "companies"
  add_foreign_key "users", "groups", column: "groups_id"
end
