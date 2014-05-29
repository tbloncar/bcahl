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

ActiveRecord::Schema.define(version: 20140529002103) do

  create_table "bulletins", force: true do |t|
    t.text     "message"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "date_and_time"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "path"
  end

  create_table "galleries", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "date_start"
    t.date     "date_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.integer  "season_id"
    t.datetime "date_and_time"
    t.boolean  "ot"
    t.integer  "home_id"
    t.integer  "away_id"
    t.integer  "home_goals"
    t.integer  "away_goals"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", force: true do |t|
    t.string   "name"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "description"
    t.integer  "gallery_id"
  end

  create_table "players", force: true do |t|
    t.string   "f_name"
    t.string   "l_name"
    t.string   "full_name"
    t.string   "email"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roster_spots", force: true do |t|
    t.integer  "player_id"
    t.integer  "roster_id"
    t.boolean  "captain",    default: false
    t.integer  "goals",      default: 0
    t.integer  "assists",    default: 0
    t.integer  "pim",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rosters", force: true do |t|
    t.integer  "season_id"
    t.integer  "team_id"
    t.integer  "wins",          default: 0
    t.integer  "losses",        default: 0
    t.integer  "points",        default: 0
    t.integer  "ot_losses",     default: 0
    t.integer  "so_wins",       default: 0
    t.integer  "goals_for",     default: 0
    t.integer  "goals_against", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ties",          default: 0
  end

  create_table "seasons", force: true do |t|
    t.string   "name"
    t.string   "path"
    t.integer  "league_id"
    t.boolean  "active",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "f_name"
    t.string   "l_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
