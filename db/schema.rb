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

ActiveRecord::Schema[7.0].define(version: 2023_06_30_223922) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "account_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "referral_key"
    t.string "account_logo"
    t.string "account_description"
    t.float "account_rates"
    t.integer "account_admin"
    t.bigint "user_id"
    t.index ["account_name"], name: "index_accounts_on_account_name", unique: true
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

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

  create_table "clients", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "phone1", default: "", null: false
    t.string "phone2"
    t.string "address"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "emergcontact_name"
    t.string "emergcontact_phone"
    t.string "schedule"
    t.float "rate"
    t.string "payment_method"
    t.integer "allowance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.bigint "pet_id"
    t.bigint "user_id"
    t.index ["account_id"], name: "index_clients_on_account_id"
    t.index ["address"], name: "index_clients_on_address"
    t.index ["address2"], name: "index_clients_on_address2"
    t.index ["allowance"], name: "index_clients_on_allowance"
    t.index ["city"], name: "index_clients_on_city"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["emergcontact_name"], name: "index_clients_on_emergcontact_name"
    t.index ["emergcontact_phone"], name: "index_clients_on_emergcontact_phone"
    t.index ["id"], name: "index_clients_on_id", unique: true
    t.index ["name"], name: "index_clients_on_name"
    t.index ["payment_method"], name: "index_clients_on_payment_method"
    t.index ["pet_id"], name: "index_clients_on_pet_id"
    t.index ["phone1"], name: "index_clients_on_phone1"
    t.index ["phone2"], name: "index_clients_on_phone2"
    t.index ["rate"], name: "index_clients_on_rate"
    t.index ["schedule"], name: "index_clients_on_schedule"
    t.index ["state"], name: "index_clients_on_state"
    t.index ["user_id"], name: "index_clients_on_user_id"
    t.index ["zipcode"], name: "index_clients_on_zipcode"
  end

  create_table "currents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mains", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "password_resets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "passwords", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pets", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "nickname"
    t.string "photo"
    t.string "breed", default: ""
    t.string "sex", default: ""
    t.string "neutered", default: ""
    t.float "age"
    t.datetime "birthday"
    t.float "weight"
    t.string "coat"
    t.string "eyecolor"
    t.string "features"
    t.string "allergies"
    t.string "medical_history"
    t.string "groups", default: ""
    t.string "puppies", default: ""
    t.string "toys"
    t.string "treats"
    t.string "notes"
    t.string "schedule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id"
    t.bigint "account_id"
    t.index ["account_id"], name: "index_pets_on_account_id"
    t.index ["age"], name: "index_pets_on_age"
    t.index ["allergies"], name: "index_pets_on_allergies"
    t.index ["birthday"], name: "index_pets_on_birthday"
    t.index ["breed"], name: "index_pets_on_breed"
    t.index ["client_id"], name: "index_pets_on_client_id"
    t.index ["coat"], name: "index_pets_on_coat"
    t.index ["eyecolor"], name: "index_pets_on_eyecolor"
    t.index ["features"], name: "index_pets_on_features"
    t.index ["groups"], name: "index_pets_on_groups"
    t.index ["id"], name: "index_pets_on_id", unique: true
    t.index ["medical_history"], name: "index_pets_on_medical_history"
    t.index ["name"], name: "index_pets_on_name"
    t.index ["neutered"], name: "index_pets_on_neutered"
    t.index ["nickname"], name: "index_pets_on_nickname"
    t.index ["notes"], name: "index_pets_on_notes"
    t.index ["puppies"], name: "index_pets_on_puppies"
    t.index ["schedule"], name: "index_pets_on_schedule"
    t.index ["sex"], name: "index_pets_on_sex"
    t.index ["toys"], name: "index_pets_on_toys"
    t.index ["treats"], name: "index_pets_on_treats"
    t.index ["weight"], name: "index_pets_on_weight"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "account"
    t.integer "role"
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
    t.string "referral_key"
    t.bigint "client_id"
    t.index ["account"], name: "index_users_on_account"
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["client_id"], name: "index_users_on_client_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id"], name: "index_users_on_id", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["role"], name: "index_users_on_role"
  end

  create_table "walks", force: :cascade do |t|
    t.datetime "startdatetime", null: false
    t.string "group", default: ""
    t.decimal "duration", precision: 21, scale: 2, default: "0.0", null: false
    t.string "notes"
    t.string "status", default: "Scheduled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pet_id"
    t.bigint "client_id"
    t.bigint "account_id"
    t.index ["account_id"], name: "index_walks_on_account_id"
    t.index ["client_id"], name: "index_walks_on_client_id"
    t.index ["duration"], name: "index_walks_on_duration"
    t.index ["group"], name: "index_walks_on_group"
    t.index ["id"], name: "index_walks_on_id", unique: true
    t.index ["notes"], name: "index_walks_on_notes"
    t.index ["pet_id"], name: "index_walks_on_pet_id"
    t.index ["startdatetime"], name: "index_walks_on_startdatetime"
    t.index ["status"], name: "index_walks_on_status"
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "clients", "accounts"
  add_foreign_key "clients", "pets"
  add_foreign_key "clients", "users"
  add_foreign_key "pets", "accounts"
  add_foreign_key "pets", "clients"
  add_foreign_key "users", "accounts"
  add_foreign_key "users", "clients"
  add_foreign_key "walks", "accounts"
  add_foreign_key "walks", "clients"
  add_foreign_key "walks", "pets"
end
