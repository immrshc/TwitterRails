# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160220173913) do

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",      limit: 4,     null: false
    t.string   "post_token",   limit: 255,   null: false
    t.text     "text",         limit: 65535, null: false
    t.float    "latitude",     limit: 24
    t.float    "longitude",    limit: 24
    t.string   "image_key",    limit: 255
    t.string   "image_ctype",  limit: 255
    t.integer  "reply_id",     limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.float    "image_width",  limit: 24
    t.float    "image_height", limit: 24
  end

  add_index "posts", ["post_token"], name: "index_posts_on_post_token", unique: true, using: :btree
  add_index "posts", ["reply_id"], name: "index_posts_on_reply_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id",  limit: 4, null: false
    t.integer  "following_id", limit: 4, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "relationships", ["follower_id", "following_id"], name: "index_relationships_on_follower_id_and_following_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree
  add_index "relationships", ["following_id"], name: "index_relationships_on_following_id", using: :btree

  create_table "responses", force: :cascade do |t|
    t.string   "type",       limit: 255, null: false
    t.integer  "user_id",    limit: 4,   null: false
    t.integer  "post_id",    limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "responses", ["post_id"], name: "index_responses_on_post_id", using: :btree
  add_index "responses", ["type"], name: "index_responses_on_type", using: :btree
  add_index "responses", ["user_id"], name: "index_responses_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "user_token",      limit: 255, null: false
    t.string   "username",        limit: 255, null: false
    t.string   "icon_image_url",  limit: 255
    t.string   "hashed_password", limit: 255, null: false
    t.string   "email",           limit: 255, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "user_identifier", limit: 255, null: false
  end

  add_index "users", ["user_token"], name: "index_users_on_user_token", unique: true, using: :btree

end
