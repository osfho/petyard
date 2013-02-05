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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130204113102) do

  create_table "features", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "position"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "forum_categories", :force => true do |t|
    t.string   "title"
    t.integer  "position",   :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "forums", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "position",          :default => 1
    t.integer  "forum_category_id", :default => 1
    t.string   "permalink"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "accessibility",     :default => "open"
  end

  create_table "mod_messages", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "news", :force => true do |t|
    t.string   "tweet_id"
    t.string   "screen_name"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "hidden"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ranks", :force => true do |t|
    t.string   "title"
    t.integer  "power"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.boolean  "locked"
    t.boolean  "sticky"
    t.integer  "user_id"
    t.integer  "forum_id"
    t.string   "permalink"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "latest_post_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                    :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.integer  "rank_id",                      :default => 2
    t.string   "title"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.integer  "failed_logins_count",          :default => 0
    t.datetime "lock_expires_at"
    t.string   "unlock_token"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
  end

  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
