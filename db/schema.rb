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

ActiveRecord::Schema.define(version: 20160507182828) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buygd", force: :cascade do |t|
    t.integer  "Food_Category_Code"
    t.text     "Food_Description"
    t.integer  "Buying_Guide_Code"
    t.integer  "Sequence_Number"
    t.text     "Purchase_Unit"
    t.text     "Preparation_Desc"
    t.decimal  "Edible_Portion_Amt",     precision: 64, scale: 12
    t.text     "Edible_Portion_Measure"
    t.datetime "Date_added"
    t.datetime "Last_modified"
    t.text     "Status"
  end

  add_index "buygd", ["Buying_Guide_Code"], name: "index_buygd_on_Buying_Guide_Code", using: :btree

  create_table "bygdlnk", force: :cascade do |t|
    t.integer  "CN_Code"
    t.integer  "Buying_Guide_Code"
    t.datetime "Date_added"
    t.datetime "Last_modified"
    t.text     "status"
  end

  add_index "bygdlnk", ["Buying_Guide_Code"], name: "index_bygdlnk_on_Buying_Guide_Code", using: :btree
  add_index "bygdlnk", ["CN_Code"], name: "index_bygdlnk_on_CN_Code", using: :btree

  create_table "ctgnme", force: :cascade do |t|
    t.integer  "Food_Category_Code"
    t.text     "Category_Description"
    t.datetime "Date_added"
    t.datetime "Last_modified"
    t.text     "Status"
  end

  add_index "ctgnme", ["Food_Category_Code"], name: "index_ctgnme_on_Food_Category_Code", using: :btree

  create_table "fdes", force: :cascade do |t|
    t.integer  "Food_Category_Code"
    t.text     "Descriptor"
    t.text     "Abbr_Desc"
    t.integer  "CN_Code"
    t.text     "Product_Code"
    t.text     "MFR_Name"
    t.text     "Commodity_Or_Recipe_Code"
    t.integer  "Source_Code"
    t.datetime "Date_added"
    t.datetime "Last_modified"
    t.text     "Status"
    t.text     "Form_of_Food"
  end

  add_index "fdes", ["CN_Code"], name: "index_fdes_on_CN_Code", using: :btree
  add_index "fdes", ["Food_Category_Code"], name: "index_fdes_on_Food_Category_Code", using: :btree

  create_table "nutdes", force: :cascade do |t|
    t.integer  "Nutrient_Code"
    t.text     "Nutrient_Description"
    t.text     "Nutrient_Desc_abrv"
    t.text     "Nutrient_Unit"
    t.datetime "Date_added"
    t.datetime "Last_modified"
    t.text     "Status"
  end

  add_index "nutdes", ["Nutrient_Code"], name: "index_nutdes_on_Nutrient_Code", using: :btree

  create_table "nutval", force: :cascade do |t|
    t.integer  "CN_Code"
    t.integer  "Nutrient_Code"
    t.decimal  "Nutrient_Value",  precision: 64, scale: 12
    t.integer  "Value_Type_Code"
    t.datetime "Date_added"
    t.datetime "Last_modified"
    t.text     "Status"
  end

  add_index "nutval", ["CN_Code"], name: "index_nutval_on_CN_Code", using: :btree
  add_index "nutval", ["Nutrient_Code"], name: "index_nutval_on_Nutrient_Code", using: :btree

  create_table "releases", force: :cascade do |t|
    t.string   "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wght", force: :cascade do |t|
    t.integer  "CN_Code"
    t.integer  "Weights_Sequence_Number"
    t.decimal  "Amount",                  precision: 64, scale: 12
    t.text     "Measure_desc"
    t.decimal  "Gram_Weight",             precision: 64, scale: 12
    t.datetime "Date_added"
    t.datetime "Last_modified"
    t.text     "Status"
  end

  add_index "wght", ["CN_Code"], name: "index_wght_on_CN_Code", using: :btree

end
