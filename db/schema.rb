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

ActiveRecord::Schema.define(version: 2019_10_10_203411) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "billing_options", force: :cascade do |t|
    t.string "name"
  end

  create_table "cart_line_items", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "product_id"
    t.bigint "cart_id"
    t.index ["cart_id"], name: "index_cart_line_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_line_items_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "cart_subtotal"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "checkouts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "order_id"
    t.string "line_items", default: [], array: true
    t.index ["order_id"], name: "index_checkouts_on_order_id"
    t.index ["user_id"], name: "index_checkouts_on_user_id"
  end

  create_table "order_line_items", force: :cascade do |t|
    t.bigint "order_id"
    t.integer "quantity"
    t.integer "product"
    t.index ["order_id"], name: "index_order_line_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "products", default: [], array: true
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_subtotal"
    t.bigint "order_shipping"
    t.bigint "order_tax"
    t.bigint "order_total"
    t.string "shipping_first_name"
    t.string "shipping_last_name"
    t.string "shipping_address_line_1"
    t.string "shipping_address_line_2"
    t.string "shipping_country"
    t.string "shipping_city"
    t.integer "shipping_zip_code"
    t.string "shipping_phone_number"
    t.string "shipping_email_address"
    t.string "shipping_option"
    t.string "billing_first_name"
    t.string "billing_last_name"
    t.string "billing_address_line_1"
    t.string "billing_address_line_2"
    t.string "billing_country"
    t.string "billing_city"
    t.integer "billing_zip_code"
    t.string "billing_phone_number"
    t.string "billing_email_address"
    t.string "shipping_state"
    t.string "billing_state"
    t.boolean "shipping_details_completed", default: false
    t.boolean "shipping_option_completed", default: false
    t.boolean "billing_details_completed", default: false
    t.boolean "shipping_same_as_billing", default: false
    t.string "billing_option"
    t.boolean "order_completed", default: false
    t.index ["products", "user_id"], name: "index_orders_on_products_and_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", default: ""
    t.string "product_type", default: ""
    t.text "description", default: ""
    t.json "image", default: ""
    t.integer "user_id", default: 0
    t.decimal "price", precision: 5, scale: 2, default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug", null: false
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "shipping_options", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 30, scale: 10
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "role"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "guest", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cart_line_items", "carts"
  add_foreign_key "cart_line_items", "products"
  add_foreign_key "carts", "users"
  add_foreign_key "checkouts", "orders"
  add_foreign_key "checkouts", "users"
  add_foreign_key "order_line_items", "orders"
end
