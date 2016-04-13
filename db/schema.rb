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

ActiveRecord::Schema.define(version: 20160411180832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "football_events", force: :cascade do |t|
    t.text     "event_name"
    t.date     "event_date"
    t.string   "event_time"
    t.string   "team_first"
    t.string   "team_second"
    t.string   "championship"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.float    "inverse_sum"
  end

  create_table "football_trades", force: :cascade do |t|
    t.integer  "football_event_id"
    t.string   "bet_platform_name"
    t.text     "bet_platform_url"
    t.text     "scrap_code"
    t.string   "team_first_name"
    t.string   "team_second_name"
    t.date     "event_date"
    t.string   "event_time"
    t.float    "first_winning_ratio"
    t.float    "both_winning_ratio"
    t.float    "second_winning_ratio"
    t.datetime "last_update"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "football_trades", ["football_event_id"], name: "index_football_trades_on_football_event_id", using: :btree

  create_table "sport_event_tradings", force: :cascade do |t|
    t.integer  "sport_event_id"
    t.integer  "sport_trade_id"
    t.string   "sport_trade_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "sport_event_tradings", ["sport_event_id"], name: "index_sport_event_tradings_on_sport_event_id", using: :btree

  create_table "sport_events", force: :cascade do |t|
    t.string   "event_name"
    t.date     "event_date"
    t.string   "event_time"
    t.string   "team_first"
    t.string   "team_second"
    t.string   "championship"
    t.string   "sport"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "inverse_sum"
    t.integer  "scenario_choice"
    t.string   "scenario_name"
  end

  create_table "sport_odds", force: :cascade do |t|
    t.integer  "sport_trade_id"
    t.string   "name"
    t.float    "value"
    t.datetime "last_update"
    t.text     "description"
    t.string   "scenario_name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "sport_odds", ["sport_trade_id"], name: "index_sport_odds_on_sport_trade_id", using: :btree

  create_table "sport_trades", force: :cascade do |t|
    t.integer  "sport_event_id"
    t.string   "platform_name"
    t.text     "platform_url"
    t.string   "sport"
    t.integer  "scenario_choice"
    t.string   "scenario_name"
    t.string   "team_first"
    t.string   "team_second"
    t.string   "event_name"
    t.date     "event_date"
    t.string   "event_time"
    t.datetime "last_update"
    t.float    "inverse_sum"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "sport_trades", ["sport_event_id"], name: "index_sport_trades_on_sport_event_id", using: :btree

  create_table "tennis_trades", force: :cascade do |t|
    t.string   "bet_platform_name"
    t.text     "bet_platform_url"
    t.string   "team_first_name"
    t.string   "team_second_name"
    t.date     "event_date"
    t.string   "event_time"
    t.float    "first_ratio"
    t.float    "second_ratio"
    t.integer  "sport_event_id"
    t.datetime "last_update"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "tennis_trades", ["sport_event_id"], name: "index_tennis_trades_on_sport_event_id", using: :btree

  add_foreign_key "football_trades", "football_events"
  add_foreign_key "sport_event_tradings", "sport_events"
  add_foreign_key "sport_odds", "sport_trades"
  add_foreign_key "sport_trades", "sport_events"
  add_foreign_key "tennis_trades", "sport_events"
end
