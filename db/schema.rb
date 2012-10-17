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

ActiveRecord::Schema.define(:version => 20121017232320) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories_items", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "item_id"
  end

  create_table "denounces", :force => true do |t|
    t.integer "user_id"
    t.integer "item_id"
  end

  create_table "items", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "path"
    t.string   "size"
    t.string   "bytes"
    t.string   "mime_type"
    t.string   "description"
    t.string   "tags"
    t.string   "category"
    t.string   "checksum"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "category_id"
    t.string   "category_as"
  end

  add_index "items", ["checksum"], :name => "index_items_on_checksum"
  add_index "items", ["tags"], :name => "index_items_on_tags"
  add_index "items", ["user_id"], :name => "index_items_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "uid"
    t.string   "name"
    t.string   "token"
    t.string   "secret"
    t.string   "country"
    t.string   "checksum"
    t.string   "delta_cursor"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "users", ["uid"], :name => "index_users_on_uid"

end
