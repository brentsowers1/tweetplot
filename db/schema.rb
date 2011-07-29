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

ActiveRecord::Schema.define(:version => 20110729154137) do

  create_table "search_tweets", :force => true do |t|
    t.integer  "search_id"
    t.string   "text"
    t.string   "author_name"
    t.string   "author_pic"
    t.time     "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.point    "location",    :limit => nil, :srid => 4326
    t.float    "lat"
    t.float    "lng"
  end

  create_table "searches", :force => true do |t|
    t.text     "term"
    t.time     "last_queried"
    t.integer  "pages_retrieved", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
