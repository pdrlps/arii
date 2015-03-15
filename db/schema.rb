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

ActiveRecord::Schema.define(version: 20150313151938) do

  create_table "agent_mappings", force: :cascade do |t|
    t.integer  "integration_id", limit: 4
    t.integer  "agent_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agents", force: :cascade do |t|
    t.string   "publisher",     limit: 255
    t.text     "payload",       limit: 65535
    t.text     "memory",        limit: 65535
    t.string   "identifier",    limit: 255
    t.string   "title",         limit: 255
    t.text     "help",          limit: 65535
    t.string   "schedule",      limit: 255
    t.integer  "events_count",  limit: 4
    t.integer  "status",        limit: 4,     default: 100
    t.datetime "last_check_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agents", ["identifier"], name: "index_agents_on_identifier", unique: true, using: :btree

  create_table "alphas", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "job",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token", limit: 255
    t.string   "user_id",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "token",      limit: 255
    t.string   "secret",     limit: 255
    t.string   "username",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "caches", force: :cascade do |t|
    t.string   "publisher",  limit: 255
    t.integer  "agent_id",   limit: 4
    t.text     "payload",    limit: 65535
    t.text     "memory",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "seed",       limit: 255
  end

  add_index "caches", ["id"], name: "index_caches_on_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "events", force: :cascade do |t|
    t.text     "payload",    limit: 65535
    t.text     "memory",     limit: 65535
    t.integer  "agent_id",   limit: 4
    t.integer  "status",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "subject",    limit: 255
    t.text     "message",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "origin",     limit: 255
    t.text     "payload",    limit: 65535
  end

  create_table "integration_mappings", force: :cascade do |t|
    t.integer  "integration_id", limit: 4
    t.integer  "template_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "integrations", force: :cascade do |t|
    t.string   "identifier", limit: 255
    t.string   "title",      limit: 255
    t.text     "help",       limit: 65535
    t.text     "payload",    limit: 65535
    t.text     "memory",     limit: 65535
    t.integer  "status",     limit: 4,     default: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "integrations", ["identifier"], name: "index_integrations_on_identifier", unique: true, using: :btree

  create_table "seed_mappings", force: :cascade do |t|
    t.integer  "agent_id",   limit: 4
    t.integer  "seed_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seeds", force: :cascade do |t|
    t.string   "identifier", limit: 255
    t.string   "title",      limit: 255
    t.string   "publisher",  limit: 255
    t.text     "help",       limit: 65535
    t.text     "payload",    limit: 65535
    t.text     "memory",     limit: 65535
    t.integer  "status",     limit: 4,     default: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "templates", force: :cascade do |t|
    t.string   "identifier",      limit: 255
    t.text     "title",           limit: 65535
    t.text     "help",            limit: 65535
    t.string   "publisher",       limit: 255
    t.text     "payload",         limit: 65535
    t.text     "memory",          limit: 65535
    t.integer  "count",           limit: 4
    t.integer  "status",          limit: 4,     default: 100
    t.datetime "last_execute_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "templates", ["identifier"], name: "index_templates_on_identifier", unique: true, using: :btree

  create_table "user_agents", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "agent_id",   limit: 4
    t.integer  "status",     limit: 4, default: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_integrations", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "integration_id", limit: 4
    t.integer  "status",         limit: 4, default: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_templates", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "template_id", limit: 4
    t.integer  "status",      limit: 4, default: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",  null: false
    t.string   "encrypted_password",     limit: 255,   default: "",  null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "username",               limit: 255
    t.string   "apikey",                 limit: 255
    t.integer  "status",                 limit: 4,     default: 100
    t.string   "image",                  limit: 255
    t.string   "location",               limit: 255
    t.text     "referring_url",          limit: 65535
    t.text     "landing_url",            limit: 65535
    t.text     "meta",                   limit: 65535
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
