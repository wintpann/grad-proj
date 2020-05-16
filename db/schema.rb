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

ActiveRecord::Schema.define(version: 2020_05_16_183818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "head_events", force: :cascade do |t|
    t.string "event_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "unit"
    t.string "description", default: ""
    t.bigint "supplier_id"
    t.decimal "price_in"
    t.decimal "price_out"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_products_on_code", unique: true
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
  end

  create_table "supplier_change_events", force: :cascade do |t|
    t.bigint "head_event_id", null: false
    t.string "event_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["head_event_id"], name: "index_supplier_change_events_on_head_event_id"
  end

  create_table "supplier_create_events", force: :cascade do |t|
    t.bigint "supplier_change_event_id", null: false
    t.bigint "supplier_snap_id", null: false
    t.bigint "editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_change_event_id"], name: "index_supplier_create_events_on_supplier_change_event_id"
    t.index ["supplier_snap_id"], name: "index_supplier_create_events_on_supplier_snap_id"
  end

  create_table "supplier_delete_events", force: :cascade do |t|
    t.bigint "supplier_change_event_id", null: false
    t.bigint "supplier_snap_id", null: false
    t.bigint "editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_change_event_id"], name: "index_supplier_delete_events_on_supplier_change_event_id"
    t.index ["supplier_snap_id"], name: "index_supplier_delete_events_on_supplier_snap_id"
  end

  create_table "supplier_edit_events", force: :cascade do |t|
    t.bigint "supplier_change_event_id", null: false
    t.bigint "from_snap_id"
    t.bigint "to_snap_id"
    t.bigint "editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_change_event_id"], name: "index_supplier_edit_events_on_supplier_change_event_id"
  end

  create_table "supplier_restore_events", force: :cascade do |t|
    t.bigint "supplier_change_event_id", null: false
    t.bigint "supplier_snap_id", null: false
    t.bigint "editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_change_event_id"], name: "index_supplier_restore_events_on_supplier_change_event_id"
    t.index ["supplier_snap_id"], name: "index_supplier_restore_events_on_supplier_snap_id"
  end

  create_table "supplier_snaps", force: :cascade do |t|
    t.bigint "supplier_id"
    t.string "name"
    t.string "phone"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_change_events", force: :cascade do |t|
    t.bigint "head_event_id", null: false
    t.string "event_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["head_event_id"], name: "index_user_change_events_on_head_event_id"
  end

  create_table "user_create_events", force: :cascade do |t|
    t.bigint "user_change_event_id", null: false
    t.bigint "user_snap_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_change_event_id"], name: "index_user_create_events_on_user_change_event_id"
    t.index ["user_snap_id"], name: "index_user_create_events_on_user_snap_id"
  end

  create_table "user_delete_events", force: :cascade do |t|
    t.bigint "user_change_event_id", null: false
    t.bigint "user_snap_id", null: false
    t.bigint "editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_change_event_id"], name: "index_user_delete_events_on_user_change_event_id"
    t.index ["user_snap_id"], name: "index_user_delete_events_on_user_snap_id"
  end

  create_table "user_edit_events", force: :cascade do |t|
    t.bigint "user_change_event_id", null: false
    t.bigint "from_snap_id"
    t.bigint "to_snap_id"
    t.bigint "editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_change_event_id"], name: "index_user_edit_events_on_user_change_event_id"
  end

  create_table "user_restore_events", force: :cascade do |t|
    t.bigint "user_change_event_id", null: false
    t.bigint "user_snap_id", null: false
    t.bigint "editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_change_event_id"], name: "index_user_restore_events_on_user_change_event_id"
    t.index ["user_snap_id"], name: "index_user_restore_events_on_user_snap_id"
  end

  create_table "user_snaps", force: :cascade do |t|
    t.bigint "user_id"
    t.string "identifier"
    t.string "name"
    t.string "lastname"
    t.string "role"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "identifier"
    t.string "name"
    t.string "lastname"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "role", default: "none"
    t.boolean "active", default: true
    t.datetime "last_seen", default: "2020-05-16 19:37:55"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["identifier"], name: "index_users_on_identifier", unique: true
  end

  create_table "warehouses", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_warehouses_on_product_id"
  end

  add_foreign_key "supplier_change_events", "head_events"
  add_foreign_key "supplier_create_events", "supplier_change_events"
  add_foreign_key "supplier_create_events", "supplier_snaps"
  add_foreign_key "supplier_delete_events", "supplier_change_events"
  add_foreign_key "supplier_delete_events", "supplier_snaps"
  add_foreign_key "supplier_edit_events", "supplier_change_events"
  add_foreign_key "supplier_restore_events", "supplier_change_events"
  add_foreign_key "supplier_restore_events", "supplier_snaps"
  add_foreign_key "user_change_events", "head_events"
  add_foreign_key "user_create_events", "user_change_events"
  add_foreign_key "user_create_events", "user_snaps"
  add_foreign_key "user_delete_events", "user_change_events"
  add_foreign_key "user_delete_events", "user_snaps"
  add_foreign_key "user_edit_events", "user_change_events"
  add_foreign_key "user_restore_events", "user_change_events"
  add_foreign_key "user_restore_events", "user_snaps"
  add_foreign_key "warehouses", "products"
end
