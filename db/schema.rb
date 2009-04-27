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

ActiveRecord::Schema.define(:version => 20090419075430) do

  create_table "areas", :force => true do |t|
    t.string "area_name"
  end

  create_table "areas_professions", :id => false, :force => true do |t|
    t.integer "area_id"
    t.integer "profession_id"
  end

  create_table "areas_subareas", :id => false, :force => true do |t|
    t.integer "area_id"
    t.integer "subarea_id"
  end

  create_table "areas_themes", :id => false, :force => true do |t|
    t.integer "area_id"
    t.integer "theme_id"
  end

  create_table "grades", :force => true do |t|
    t.text "grade_name", :null => false
  end

  create_table "organizations", :force => true do |t|
    t.text "organization_name", :null => false
  end

  create_table "passwords", :force => true do |t|
    t.integer  "user_id"
    t.string   "reset_code"
    t.datetime "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "professions", :force => true do |t|
    t.text    "profession_name", :null => false
    t.text    "code_name",       :null => false
    t.integer "grade_id",        :null => false
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "subareas", :force => true do |t|
    t.string "subarea_name", :null => false
  end

  create_table "subareas_themes", :id => false, :force => true do |t|
    t.integer "subarea_id"
    t.integer "theme_id"
  end

  create_table "themes", :force => true do |t|
    t.string   "theme_name",                                          :null => false
    t.string   "fio",                                                 :null => false
    t.string   "year_name",                                           :null => false
    t.text     "text_abstract",                 :limit => 2147483647, :null => false
    t.text     "text_dissertation",             :limit => 2147483647, :null => false
    t.integer  "profession_id"
    t.integer  "organization_id"
    t.string   "avtoref_doc_file_name"
    t.string   "avtoref_doc_content_type"
    t.integer  "avtoref_doc_file_size"
    t.string   "avtoref_pdf_file_name"
    t.string   "avtoref_pdf_content_type"
    t.integer  "avtoref_pdf_file_size"
    t.string   "disser_doc_file_name"
    t.string   "disser_doc_content_type"
    t.integer  "disser_doc_file_size"
    t.string   "disser_pdf_file_name"
    t.string   "disser_pdf_content_type"
    t.integer  "disser_pdf_file_size"
    t.boolean  "delta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avtoref_swf_file_name"
    t.string   "avtoref_swf_content_type"
    t.integer  "avtoref_swf_file_size"
    t.string   "disser_swf_file_name"
    t.string   "disser_swf_content_type"
    t.integer  "disser_swf_file_size"
    t.integer  "avtoref_pdf_scribd_id"
    t.string   "avtoref_pdf_scribd_access_key"
    t.integer  "disser_pdf_scribd_id"
    t.string   "disser_pdf_scribd_access_key"
    t.integer  "avtoref_doc_scribd_id"
    t.string   "avtoref_doc_scribd_access_key"
    t.integer  "disser_doc_scribd_id"
    t.string   "disser_doc_scribd_access_key"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "identity_url"
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token",            :limit => 40
    t.string   "activation_code",           :limit => 40
    t.string   "state",                                    :default => "passive", :null => false
    t.datetime "remember_token_expires_at"
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
