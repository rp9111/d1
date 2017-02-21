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

ActiveRecord::Schema.define(version: 20161018024039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.string   "label"
    t.boolean  "navigation", default: true
    t.boolean  "footer",     default: false
    t.boolean  "comments",   default: false
    t.boolean  "paid",       default: true
    t.boolean  "restricted", default: false
    t.integer  "position"
    t.integer  "theme_id"
    t.boolean  "ascending"
    t.hstore   "properties"
    t.string   "mode"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "sku_ids"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "page_id"
    t.integer  "parent_id"
    t.text     "content"
    t.datetime "submitted_at"
    t.boolean  "approved"
    t.datetime "posted_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["page_id"], name: "index_comments_on_page_id", using: :btree
    t.index ["parent_id"], name: "index_comments_on_parent_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "stripe_plan"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "ip"
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "ip_country",          limit: 255
    t.string   "ip_region",           limit: 255
    t.string   "ip_zip",              limit: 255
    t.string   "ip_latitude",         limit: 255
    t.string   "ip_longitude",        limit: 255
    t.integer  "hits",                            default: 0
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["impressionable_type", "impressionable_id"], name: "index_impressions_on_impressionable_type_and_impressionable_id", using: :btree
    t.index ["ip"], name: "index_impressions_on_ip", using: :btree
  end

  create_table "oauthids", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.string   "image_url"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_oauthids_on_user_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "cover"
    t.string   "permalink"
    t.integer  "area_id"
    t.boolean  "commentable",       default: false
    t.hstore   "properties"
    t.integer  "position"
    t.integer  "user_id"
    t.boolean  "publish",           default: true
    t.integer  "impressions_count", default: 0
    t.datetime "published_at"
    t.datetime "pull_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["area_id"], name: "index_pages_on_area_id", using: :btree
    t.index ["user_id"], name: "index_pages_on_user_id", using: :btree
  end

  create_table "promos", force: :cascade do |t|
    t.string   "name"
    t.integer  "course_id"
    t.string   "stripe_coupon"
    t.integer  "hits",          default: 0
    t.integer  "conversions",   default: 0
    t.boolean  "enabled"
    t.datetime "expires_on"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "message",       default: ""
  end

  create_table "skus", force: :cascade do |t|
    t.string   "name"
    t.string   "plan_id"
    t.integer  "amount",      default: 0
    t.string   "interval"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "description"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "area_id"
    t.datetime "expires_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "plan_id"
    t.string   "stripe_token"
    t.index ["area_id"], name: "index_subscriptions_on_area_id", using: :btree
    t.index ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  end

  create_table "themes", force: :cascade do |t|
    t.string   "name"
    t.text     "structure"
    t.text     "style"
    t.text     "behavior"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "page_id"
    t.string   "attachment"
    t.string   "caption"
    t.hstore   "properties"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_uploads_on_page_id", using: :btree
    t.index ["user_id"], name: "index_uploads_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "group_id"
    t.string   "avatar"
    t.string   "status"
    t.boolean  "confirmed"
    t.boolean  "admin"
    t.string   "token"
    t.string   "reset_token"
    t.string   "stripe_token"
    t.datetime "reset_at"
    t.text     "bio"
    t.hstore   "preferences"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "account_current"
    t.string   "plan_id"
    t.string   "stripe_id"
    t.datetime "active_until"
    t.text     "sku_ids"
    t.string   "promo"
    t.index ["group_id"], name: "index_users_on_group_id", using: :btree
  end

  add_foreign_key "comments", "pages"
  add_foreign_key "comments", "users"
  add_foreign_key "oauthids", "users"
  add_foreign_key "pages", "areas"
  add_foreign_key "pages", "users"
  add_foreign_key "subscriptions", "areas"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "uploads", "pages"
  add_foreign_key "uploads", "users"
  add_foreign_key "users", "groups"
end
