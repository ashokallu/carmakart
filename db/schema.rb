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

ActiveRecord::Schema.define(version: 2021_05_29_053749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.index ["name"], name: "index_brands_on_name", unique: true
  end

  create_table "brands_product_types", id: false, force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.bigint "product_type_id", null: false
    t.index ["brand_id", "product_type_id"], name: "index_brands_product_types_on_brand_id_and_product_type_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name", limit: 64, null: false
    t.string "last_name", limit: 64
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["first_name"], name: "index_customers_on_first_name"
    t.index ["last_name"], name: "index_customers_on_last_name"
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.text "product_attributes", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_attributes"], name: "index_product_types_on_product_attributes", using: :gin
  end

  create_table "product_variants", force: :cascade do |t|
    t.string "sku_id", limit: 16, null: false
    t.string "name", limit: 128, null: false
    t.integer "variant_price", null: false
    t.decimal "discount", precision: 5, scale: 3
    t.jsonb "variant_specific_attributes", default: "{}", null: false
    t.jsonb "product_specific_attributes", default: "{}", null: false
    t.bigint "product_id", null: false
    t.bigint "product_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_product_variants_on_name"
    t.index ["product_id"], name: "index_product_variants_on_product_id"
    t.index ["product_specific_attributes"], name: "index_product_variants_on_product_specific_attributes", using: :gin
    t.index ["product_type_id"], name: "index_product_variants_on_product_type_id"
    t.index ["sku_id"], name: "index_product_variants_on_sku_id", unique: true
    t.index ["variant_specific_attributes"], name: "index_product_variants_on_variant_specific_attributes", using: :gin
  end

  create_table "products", force: :cascade do |t|
    t.text "product_name", null: false
    t.text "product_description"
    t.text "variant_attributes", default: [], array: true
    t.bigint "product_type_id", null: false
    t.bigint "brand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["product_description"], name: "index_products_on_product_description"
    t.index ["product_name"], name: "index_products_on_product_name"
    t.index ["product_type_id"], name: "index_products_on_product_type_id"
    t.index ["variant_attributes"], name: "index_products_on_variant_attributes", using: :gin
  end

  add_foreign_key "product_variants", "product_types"
  add_foreign_key "product_variants", "products"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "product_types"
end
