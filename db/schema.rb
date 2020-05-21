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

ActiveRecord::Schema.define(version: 2020_05_21_103031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "arrival_events", force: :cascade do |t|
    t.bigint "production_event_id", null: false
    t.bigint "product_id", null: false
    t.bigint "product_snap_id", null: false
    t.float "amount"
    t.decimal "sum", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_arrival_events_on_product_id"
    t.index ["product_snap_id"], name: "index_arrival_events_on_product_snap_id"
    t.index ["production_event_id"], name: "index_arrival_events_on_production_event_id"
  end

  create_table "head_events", force: :cascade do |t|
    t.string "event_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "editor_id"
    t.decimal "sum", default: "0.0"
    t.string "goal_type"
    t.bigint "supplier_id"
    t.bigint "product_id"
  end

  create_table "product_change_events", force: :cascade do |t|
    t.bigint "head_event_id", null: false
    t.string "event_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["head_event_id"], name: "index_product_change_events_on_head_event_id"
  end

  create_table "product_create_events", force: :cascade do |t|
    t.bigint "product_change_event_id", null: false
    t.bigint "product_snap_id", null: false
    t.bigint "editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_change_event_id"], name: "index_product_create_events_on_product_change_event_id"
    t.index ["product_snap_id"], name: "index_product_create_events_on_product_snap_id"
  end

  create_table "product_delete_events", force: :cascade do |t|
    t.bigint "product_change_event_id", null: false
    t.bigint "product_snap_id", null: false
    t.bigint "editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_change_event_id"], name: "index_product_delete_events_on_product_change_event_id"
    t.index ["product_snap_id"], name: "index_product_delete_events_on_product_snap_id"
  end

  create_table "product_edit_events", force: :cascade do |t|
    t.bigint "product_change_event_id", null: false
    t.bigint "from_snap_id"
    t.bigint "to_snap_id"
    t.bigint "editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_change_event_id"], name: "index_product_edit_events_on_product_change_event_id"
  end

  create_table "product_restore_events", force: :cascade do |t|
    t.bigint "product_change_event_id", null: false
    t.bigint "product_snap_id", null: false
    t.bigint "editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_change_event_id"], name: "index_product_restore_events_on_product_change_event_id"
    t.index ["product_snap_id"], name: "index_product_restore_events_on_product_snap_id"
  end

  create_table "product_snaps", force: :cascade do |t|
    t.bigint "product_id"
    t.string "code"
    t.string "name"
    t.string "unit"
    t.boolean "active"
    t.string "description"
    t.bigint "supplier_id"
    t.string "supplier_name"
    t.decimal "price_in"
    t.decimal "price_out"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "production_events", force: :cascade do |t|
    t.bigint "head_event_id", null: false
    t.decimal "sum", default: "0.0"
    t.string "event_type"
    t.bigint "editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["head_event_id"], name: "index_production_events_on_head_event_id"
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

  create_table "realization_events", force: :cascade do |t|
    t.bigint "production_event_id", null: false
    t.bigint "product_id", null: false
    t.bigint "product_snap_id", null: false
    t.float "amount"
    t.decimal "sum", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_realization_events_on_product_id"
    t.index ["product_snap_id"], name: "index_realization_events_on_product_snap_id"
    t.index ["production_event_id"], name: "index_realization_events_on_production_event_id"
  end

  create_table "refund_events", force: :cascade do |t|
    t.bigint "production_event_id", null: false
    t.bigint "product_id", null: false
    t.bigint "product_snap_id", null: false
    t.float "amount"
    t.decimal "sum", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_refund_events_on_product_id"
    t.index ["product_snap_id"], name: "index_refund_events_on_product_snap_id"
    t.index ["production_event_id"], name: "index_refund_events_on_production_event_id"
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

  create_table "user_invites", force: :cascade do |t|
    t.string "invite"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invite"], name: "index_user_invites_on_invite"
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
    t.string "role", default: ""
    t.boolean "active", default: true
    t.datetime "last_seen"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["identifier"], name: "index_users_on_identifier", unique: true
  end

  create_table "warehouses", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.decimal "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_warehouses_on_product_id"
  end

  create_table "write_off_events", force: :cascade do |t|
    t.bigint "production_event_id", null: false
    t.bigint "product_id", null: false
    t.bigint "product_snap_id", null: false
    t.float "amount"
    t.decimal "sum", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_write_off_events_on_product_id"
    t.index ["product_snap_id"], name: "index_write_off_events_on_product_snap_id"
    t.index ["production_event_id"], name: "index_write_off_events_on_production_event_id"
  end

  add_foreign_key "arrival_events", "product_snaps"
  add_foreign_key "arrival_events", "production_events"
  add_foreign_key "arrival_events", "products"
  add_foreign_key "product_change_events", "head_events"
  add_foreign_key "product_create_events", "product_change_events"
  add_foreign_key "product_create_events", "product_snaps"
  add_foreign_key "product_delete_events", "product_change_events"
  add_foreign_key "product_delete_events", "product_snaps"
  add_foreign_key "product_edit_events", "product_change_events"
  add_foreign_key "product_restore_events", "product_change_events"
  add_foreign_key "product_restore_events", "product_snaps"
  add_foreign_key "production_events", "head_events"
  add_foreign_key "realization_events", "product_snaps"
  add_foreign_key "realization_events", "production_events"
  add_foreign_key "realization_events", "products"
  add_foreign_key "refund_events", "product_snaps"
  add_foreign_key "refund_events", "production_events"
  add_foreign_key "refund_events", "products"
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
  add_foreign_key "write_off_events", "product_snaps"
  add_foreign_key "write_off_events", "production_events"
  add_foreign_key "write_off_events", "products"
end
