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

ActiveRecord::Schema.define(version: 2021_10_29_174413) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shorten_urls", force: :cascade do |t|
    t.string "origin"
    t.string "alias"
    t.integer "clicked"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["alias"], name: "index_shorten_urls_on_alias", unique: true
    t.index ["user_id"], name: "index_shorten_urls_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "access_api"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["access_api"], name: "index_users_on_access_api", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "shorten_urls", "users"
end
