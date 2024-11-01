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

ActiveRecord::Schema[7.2].define(version: 2024_10_31_141155) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "beverages", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "calorie"
    t.integer "establishment_id", null: false
    t.boolean "alcoholic", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 2
    t.index ["establishment_id"], name: "index_beverages_on_establishment_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "calorie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "establishment_id", null: false
    t.integer "status", default: 2
    t.integer "marker_id"
    t.index ["establishment_id"], name: "index_dishes_on_establishment_id"
    t.index ["marker_id"], name: "index_dishes_on_marker_id"
  end

  create_table "establishments", force: :cascade do |t|
    t.string "corporate_name", null: false
    t.string "brand_name", null: false
    t.string "restration_number", null: false
    t.string "full_address", null: false
    t.string "phone_number", null: false
    t.string "email", null: false
    t.string "code", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email", "phone_number", "restration_number", "code"], name: "idx_on_email_phone_number_restration_number_code_7039483612", unique: true
    t.index ["email"], name: "index_establishments_on_email", unique: true
    t.index ["phone_number"], name: "index_establishments_on_phone_number", unique: true
    t.index ["restration_number"], name: "index_establishments_on_restration_number", unique: true
    t.index ["user_id"], name: "index_establishments_on_user_id"
  end

  create_table "historicals", force: :cascade do |t|
    t.datetime "date_of_change", null: false
    t.decimal "price", precision: 15, scale: 2, null: false
    t.integer "portion_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["portion_id"], name: "index_historicals_on_portion_id"
  end

  create_table "markers", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opening_hours", force: :cascade do |t|
    t.integer "establishment_id", null: false
    t.time "open_hour"
    t.time "close_hour"
    t.integer "day_of_week", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["establishment_id"], name: "index_opening_hours_on_establishment_id"
  end

  create_table "portions", force: :cascade do |t|
    t.string "description", null: false
    t.decimal "price", precision: 15, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "portionable_type", null: false
    t.integer "portionable_id", null: false
    t.index ["portionable_type", "portionable_id"], name: "index_portions_on_portionable"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.string "last_name", null: false
    t.string "cpf", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "beverages", "establishments"
  add_foreign_key "dishes", "establishments"
  add_foreign_key "dishes", "markers"
  add_foreign_key "establishments", "users"
  add_foreign_key "historicals", "portions"
  add_foreign_key "opening_hours", "establishments"
end
