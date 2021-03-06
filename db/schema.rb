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

ActiveRecord::Schema.define(version: 20180531150901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.string "title"
  end

  create_table "showings", force: :cascade do |t|
    t.date "date"
    t.string "time"
    t.integer "capacity"
    t.bigint "movie_id"
    t.decimal "price"
    t.index ["movie_id"], name: "index_showings_on_movie_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "showing_id"
    t.integer "quantity"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.decimal "cost"
    t.index ["showing_id"], name: "index_transactions_on_showing_id"
  end

end
