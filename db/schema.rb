# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2015_04_27_150053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agent_mappings", force: :cascade do |t|
    t.bigint "integration_id"
    t.bigint "agent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["agent_id"], name: "index_agent_mappings_on_agent_id"
    t.index ["integration_id"], name: "index_agent_mappings_on_integration_id"
  end

  create_table "agents", id: :serial, force: :cascade do |t|
    t.string "publisher"
    t.text "payload"
    t.text "memory"
    t.string "identifier"
    t.string "title"
    t.text "help"
    t.string "schedule"
    t.integer "events_count"
    t.integer "status", default: 100
    t.datetime "last_check_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["identifier"], name: "index_agents_on_identifier", unique: true
  end

  create_table "api_keys", id: :serial, force: :cascade do |t|
    t.string "access_token"
    t.string "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", id: :serial, force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.integer "user_id"
    t.string "token"
    t.string "secret"
    t.string "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "betas", id: :serial, force: :cascade do |t|
    t.string "origin"
    t.string "name"
    t.string "email"
    t.string "job"
    t.text "payload"
    t.text "what"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "caches", id: :serial, force: :cascade do |t|
    t.string "publisher"
    t.integer "agent_id"
    t.text "payload"
    t.text "memory"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "seed"
    t.index ["id"], name: "index_caches_on_id"
  end

  create_table "clients", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.text "message"
    t.text "payload"
    t.string "origin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.text "payload"
    t.text "memory"
    t.integer "agent_id"
    t.integer "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.text "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "origin"
    t.text "payload"
    t.string "details"
  end

  create_table "integration_mappings", force: :cascade do |t|
    t.bigint "integration_id"
    t.bigint "template_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["integration_id"], name: "index_integration_mappings_on_integration_id"
    t.index ["template_id"], name: "index_integration_mappings_on_template_id"
  end

  create_table "integrations", id: :serial, force: :cascade do |t|
    t.string "identifier"
    t.string "title"
    t.text "help"
    t.text "payload"
    t.text "memory"
    t.integer "status", default: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["identifier"], name: "index_integrations_on_identifier", unique: true
  end

  create_table "seed_mappings", id: :serial, force: :cascade do |t|
    t.integer "agent_id"
    t.integer "seed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seeds", id: :serial, force: :cascade do |t|
    t.string "identifier"
    t.string "title"
    t.string "publisher"
    t.text "help"
    t.text "payload"
    t.text "memory"
    t.integer "status", default: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "templates", id: :serial, force: :cascade do |t|
    t.string "identifier"
    t.text "title"
    t.text "help"
    t.string "endpoint"
    t.text "payload"
    t.text "memory"
    t.integer "count"
    t.integer "status", default: 100
    t.datetime "last_execute_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["identifier"], name: "index_templates_on_identifier", unique: true
  end

  create_table "user_agents", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "agent_id"
    t.integer "status", default: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_integrations", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "integration_id"
    t.integer "status", default: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_templates", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "template_id"
    t.integer "status", default: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.string "username"
    t.string "apikey"
    t.integer "status", default: 100
    t.string "image"
    t.string "location"
    t.text "referring_url"
    t.text "landing_url"
    t.text "meta"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
