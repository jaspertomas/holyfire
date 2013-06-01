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

ActiveRecord::Schema.define(:version => 20130601073848) do

  create_table "batches", :force => true do |t|
    t.integer  "no"
    t.string   "gender"
    t.integer  "blessing_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "blessings", :force => true do |t|
    t.string   "location"
    t.date     "date"
    t.text     "contactinfo"
    t.text     "comments"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "participants", :force => true do |t|
    t.string   "sex"
    t.string   "name"
    t.string   "age"
    t.string   "occupation"
    t.string   "introducer"
    t.string   "guarantor"
    t.string   "address"
    t.string   "tel"
    t.string   "missionary"
    t.string   "remark"
    t.string   "donation"
    t.integer  "batch_id"
    t.integer  "blessing_id"
    t.boolean  "is_finalized"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "no"
  end

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.string   "datatype"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "is_admin"
    t.boolean  "is_encoder"
    t.boolean  "is_batcher"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "remember_token"
  end

  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
