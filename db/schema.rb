# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_02_012904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brackets", force: :cascade do |t|
    t.integer "number_of_entries", default: 0
    t.string "status", default: "created"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "entries", force: :cascade do |t|
    t.bigint "bracket_id", null: false
    t.string "name"
    t.integer "seed"
    t.boolean "eliminated", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bracket_id"], name: "index_entries_on_bracket_id"
  end

  create_table "matchups", force: :cascade do |t|
    t.bigint "winner_id"
    t.integer "position"
    t.bigint "bracket_id", null: false
    t.bigint "option_a_id"
    t.bigint "option_b_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bracket_id"], name: "index_matchups_on_bracket_id"
    t.index ["option_a_id"], name: "index_matchups_on_option_a_id"
    t.index ["option_b_id"], name: "index_matchups_on_option_b_id"
    t.index ["winner_id"], name: "index_matchups_on_winner_id"
  end

  add_foreign_key "entries", "brackets"
  add_foreign_key "matchups", "brackets"
  add_foreign_key "matchups", "entries", column: "option_a_id"
  add_foreign_key "matchups", "entries", column: "option_b_id"
  add_foreign_key "matchups", "entries", column: "winner_id"
end
