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

ActiveRecord::Schema.define(:version => 20120316211326) do

  create_table "interviewer_pool_memberships", :force => true do |t|
    t.integer  "interviewer_id"
    t.integer  "interviewer_pool_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "interviewer_pool_memberships", ["interviewer_id"], :name => "index_interviewer_pool_memberships_on_interviewer_id"
  add_index "interviewer_pool_memberships", ["interviewer_pool_id"], :name => "index_interviewer_pool_memberships_on_interviewer_pool_id"

  create_table "interviewer_pools", :force => true do |t|
    t.string   "name"
    t.integer  "interviewers_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "interviewer_pools", ["interviewers_id"], :name => "index_interviewer_pools_on_interviewers_id"

  create_table "interviewer_pools_interviewers", :id => false, :force => true do |t|
    t.integer "interviewer_pool_id"
    t.integer "interviewer_id"
  end

  add_index "interviewer_pools_interviewers", ["interviewer_id", "interviewer_pool_id"], :name => "ipi_i_ip"
  add_index "interviewer_pools_interviewers", ["interviewer_pool_id", "interviewer_id"], :name => "ipi_ip_i"

  create_table "interviewer_tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "interviewers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "interviewer_tags_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "interviewers", ["interviewer_tags_id"], :name => "index_interviewers_on_interviewer_tags_id"

  create_table "panel_rejected_interviewers", :id => false, :force => true do |t|
    t.integer "panel_id"
    t.integer "interviewer_id"
  end

  create_table "panels", :force => true do |t|
    t.string   "candidate"
    t.string   "email"
    t.string   "position"
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.integer  "panel_id"
    t.datetime "start"
    t.datetime "end"
    t.integer  "interviewer_id"
    t.integer  "rejected_interviewers_id"
    t.integer  "state"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "interviewer_pool_id"
  end

  add_index "sessions", ["interviewer_id"], :name => "index_sessions_on_interviewer_id"
  add_index "sessions", ["panel_id"], :name => "index_sessions_on_panel_id"
  add_index "sessions", ["rejected_interviewers_id"], :name => "index_sessions_on_rejected_interviewers_id"

end
