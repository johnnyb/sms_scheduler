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

ActiveRecord::Schema.define(version: 20160802222906) do

  create_table "scheduled_messages", force: :cascade do |t|
    t.string   "source_type"
    t.string   "source_subtype"
    t.text     "source_url"
    t.text     "destination_phone"
    t.text     "source_phone"
    t.string   "requestor_ip_address"
    t.text     "message"
    t.text     "requested_by_name"
    t.datetime "send_at"
    t.datetime "sent_at"
    t.string   "status_code"
    t.text     "status_message"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
