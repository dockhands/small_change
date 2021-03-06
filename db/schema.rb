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

ActiveRecord::Schema.define(version: 2018_12_04_194232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "deed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "users_id"
    t.integer "user_id"
    t.index ["deed_id"], name: "index_comments_on_deed_id"
    t.index ["users_id"], name: "index_comments_on_users_id"
  end

  create_table "deeds", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "money_required"
    t.integer "money_raised"
    t.string "image_url"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "slug"
    t.float "latitude"
    t.float "longitude"
    t.string "city"
    t.string "address"
    t.string "aasm_state"
    t.text "completed_body"
    t.index ["slug"], name: "index_deeds_on_slug", unique: true
    t.index ["user_id"], name: "index_deeds_on_user_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "funds", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "deed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deed_id"], name: "index_funds_on_deed_id"
    t.index ["user_id"], name: "index_funds_on_user_id"
  end

  create_table "gifts", force: :cascade do |t|
    t.float "amount"
    t.integer "sender_id"
    t.integer "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "deed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "score"
    t.text "body"
    t.index ["deed_id"], name: "index_ratings_on_deed_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "deed_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deed_id"], name: "index_taggings_on_deed_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name"
  end

  create_table "uninteresteds", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "deed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deed_id"], name: "index_uninteresteds_on_deed_id"
    t.index ["user_id"], name: "index_uninteresteds_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "wallet"
    t.float "latitude"
    t.float "longitude"
    t.string "city"
    t.string "address"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "uid"
    t.string "provider"
    t.string "oauth_token"
    t.text "oauth_raw_data"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider"
  end

  add_foreign_key "comments", "deeds"
  add_foreign_key "comments", "users", column: "users_id"
  add_foreign_key "deeds", "users"
  add_foreign_key "funds", "deeds"
  add_foreign_key "funds", "users"
  add_foreign_key "ratings", "deeds"
  add_foreign_key "ratings", "users"
  add_foreign_key "taggings", "deeds"
  add_foreign_key "taggings", "tags"
  add_foreign_key "uninteresteds", "deeds"
  add_foreign_key "uninteresteds", "users"
end
