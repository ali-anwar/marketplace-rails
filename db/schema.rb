# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110326031248) do

  create_table "ads", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.boolean  "show_phone"
    t.integer  "category_id"
    t.integer  "city_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.float    "price"
    t.boolean  "approved"
    t.boolean  "private"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "delta",       :default => true, :null => false
  end

  create_table "categories", :force => true do |t|
    t.string "name"
    t.string "parent"
  end

  create_table "cities", :force => true do |t|
    t.string "name"
    t.string "region"
  end

  create_table "details", :force => true do |t|
    t.integer "ad_id"
    t.string  "status"
    t.string  "address"
    t.integer "number_of_rooms"
    t.integer "size"
    t.integer "vehicle_registration_year"
    t.integer "vehicle_mileage"
    t.integer "vehicle_category"
  end

  add_index "details", ["ad_id"], :name => "index_details_on_ad_id"

  create_table "uploads", :force => true do |t|
    t.integer "ad_id"
    t.string  "photo_file_name"
    t.integer "photo_file_size"
  end

  add_index "uploads", ["ad_id"], :name => "index_uploads_on_ad_id"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
