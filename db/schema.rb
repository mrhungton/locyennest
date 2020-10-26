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

ActiveRecord::Schema.define(version: 20201026032351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "erp_articles_articles", id: :serial, force: :cascade do |t|
    t.string "image"
    t.string "name"
    t.text "content"
    t.string "meta_keywords"
    t.string "meta_description"
    t.string "tags"
    t.boolean "archived", default: false
    t.integer "category_id"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "custom_order"
    t.index ["category_id"], name: "index_erp_articles_articles_on_category_id"
    t.index ["creator_id"], name: "index_erp_articles_articles_on_creator_id"
  end

  create_table "erp_articles_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "parent_id"
    t.string "alias"
    t.boolean "archived", default: false
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "custom_order"
    t.index ["creator_id"], name: "index_erp_articles_categories_on_creator_id"
  end

  create_table "erp_articles_comments", id: :serial, force: :cascade do |t|
    t.text "message"
    t.integer "parent_id"
    t.boolean "archived", default: false
    t.integer "article_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_erp_articles_comments_on_article_id"
    t.index ["user_id"], name: "index_erp_articles_comments_on_user_id"
  end

  create_table "erp_banners_banners", id: :serial, force: :cascade do |t|
    t.string "image_url"
    t.string "name"
    t.string "link_url"
    t.boolean "archived", default: false
    t.integer "category_id"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "custom_order"
    t.text "note"
    t.index ["category_id"], name: "index_erp_banners_banners_on_category_id"
    t.index ["creator_id"], name: "index_erp_banners_banners_on_creator_id"
  end

  create_table "erp_banners_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "width"
    t.integer "height"
    t.string "image_scale"
    t.boolean "archived", default: false
    t.string "position"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_erp_banners_categories_on_creator_id"
  end

  create_table "erp_carts_cart_items", id: :serial, force: :cascade do |t|
    t.integer "quantity", default: 1
    t.integer "product_id"
    t.integer "cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_erp_carts_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_erp_carts_cart_items_on_product_id"
  end

  create_table "erp_carts_carts", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "erp_carts_compare_items", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "compare_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compare_id"], name: "index_erp_carts_compare_items_on_compare_id"
    t.index ["product_id"], name: "index_erp_carts_compare_items_on_product_id"
  end

  create_table "erp_carts_compares", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "erp_carts_wish_lists", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_erp_carts_wish_lists_on_product_id"
    t.index ["user_id"], name: "index_erp_carts_wish_lists_on_user_id"
  end

  create_table "erp_contact_groups_price_lists", id: :serial, force: :cascade do |t|
    t.integer "price_list_id"
    t.integer "contact_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_group_id"], name: "index_erp_contact_groups_price_lists_on_contact_group_id"
    t.index ["price_list_id"], name: "index_erp_contact_groups_price_lists_on_price_list_id"
  end

  create_table "erp_editor_uploads", id: :serial, force: :cascade do |t|
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "erp_menus_menus", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.string "style_icon"
    t.string "style_color"
    t.string "image_url_1"
    t.string "image_url_2"
    t.string "menu_icon"
    t.string "image_menu_link_1"
    t.string "image_menu_link_2"
    t.text "description"
    t.text "meta_keywords"
    t.text "meta_description"
    t.boolean "is_hot", default: false
    t.boolean "archived", default: false
    t.integer "creator_id"
    t.integer "brand_group_id"
    t.integer "custom_order"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "brand_id"
    t.string "image_menu"
    t.string "image_menu_title"
    t.string "image_menu_link"
    t.text "cache_search"
    t.boolean "is_show_detail", default: true
    t.integer "number_per_page", default: 12
    t.boolean "use_filter", default: false
    t.index ["brand_group_id"], name: "index_erp_menus_menus_on_brand_group_id"
    t.index ["creator_id"], name: "index_erp_menus_menus_on_creator_id"
  end

  create_table "erp_menus_menus_products_categories", id: :serial, force: :cascade do |t|
    t.integer "menu_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_erp_menus_menus_products_categories_on_category_id"
    t.index ["menu_id"], name: "index_erp_menus_menus_products_categories_on_menu_id"
  end

  create_table "erp_menus_related_menus", id: :serial, force: :cascade do |t|
    t.integer "parent_id"
    t.integer "menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_erp_menus_related_menus_on_menu_id"
    t.index ["parent_id"], name: "index_erp_menus_related_menus_on_parent_id"
  end

  create_table "erp_newsletters_newsletters", id: :serial, force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "erp_products_accessories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "archived", default: false
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_erp_products_accessories_on_creator_id"
  end

  create_table "erp_products_accessory_details", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "accessory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accessory_id"], name: "index_erp_products_accessory_details_on_accessory_id"
    t.index ["product_id"], name: "index_erp_products_accessory_details_on_product_id"
  end

  create_table "erp_products_brand_group_details", id: :serial, force: :cascade do |t|
    t.integer "brand_id"
    t.integer "brand_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_group_id"], name: "index_erp_products_brand_group_details_on_brand_group_id"
    t.index ["brand_id"], name: "index_erp_products_brand_group_details_on_brand_id"
  end

  create_table "erp_products_brand_groups", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "archived", default: false
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_erp_products_brand_groups_on_creator_id"
  end

  create_table "erp_products_brands", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "archived", default: false
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.boolean "is_main", default: false
    t.text "cache_search"
    t.index ["creator_id"], name: "index_erp_products_brands_on_creator_id"
  end

  create_table "erp_products_cache_stocks", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "state_id"
    t.bigint "warehouse_id"
    t.integer "stock", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_erp_products_cache_stocks_on_product_id"
    t.index ["state_id"], name: "index_erp_products_cache_stocks_on_state_id"
    t.index ["stock"], name: "index_erp_products_cache_stocks_on_stock"
    t.index ["warehouse_id"], name: "index_erp_products_cache_stocks_on_warehouse_id"
  end

  create_table "erp_products_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.boolean "archived", default: false
    t.integer "creator_id"
    t.integer "custom_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_erp_products_categories_on_creator_id"
  end

  create_table "erp_products_categories_pgroups", id: :serial, force: :cascade do |t|
    t.integer "category_id"
    t.integer "property_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_erp_products_categories_pgroups_on_category_id"
    t.index ["property_group_id"], name: "index_erp_products_categories_pgroups_on_property_group_id"
  end

  create_table "erp_products_comments", id: :serial, force: :cascade do |t|
    t.text "message"
    t.integer "parent_id"
    t.boolean "archived", default: false
    t.integer "product_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_erp_products_comments_on_product_id"
    t.index ["user_id"], name: "index_erp_products_comments_on_user_id"
  end

  create_table "erp_products_customer_taxes", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "tax_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_erp_products_customer_taxes_on_product_id"
    t.index ["tax_id"], name: "index_erp_products_customer_taxes_on_tax_id"
  end

  create_table "erp_products_damage_record_details", id: :serial, force: :cascade do |t|
    t.integer "quantity", default: 1
    t.text "note"
    t.integer "product_id"
    t.integer "damage_record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "state_id"
    t.index ["damage_record_id"], name: "index_erp_products_damage_record_details_on_damage_record_id"
    t.index ["product_id"], name: "index_erp_products_damage_record_details_on_product_id"
    t.index ["state_id"], name: "index_erp_products_damage_record_details_on_state_id"
  end

  create_table "erp_products_damage_records", id: :serial, force: :cascade do |t|
    t.string "code"
    t.datetime "date"
    t.text "description"
    t.string "status"
    t.boolean "archived", default: false
    t.integer "creator_id"
    t.integer "warehouse_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.datetime "confirmed_at"
    t.index ["creator_id"], name: "index_erp_products_damage_records_on_creator_id"
    t.index ["employee_id"], name: "index_erp_products_damage_records_on_employee_id"
    t.index ["warehouse_id"], name: "index_erp_products_damage_records_on_warehouse_id"
  end

  create_table "erp_products_events", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "from_date"
    t.datetime "to_date"
    t.string "image_url"
    t.text "description"
    t.boolean "archived", default: false
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_erp_products_events_on_creator_id"
  end

  create_table "erp_products_events_products", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "product_id"
    t.index ["event_id"], name: "index_erp_products_events_products_on_event_id"
    t.index ["product_id"], name: "index_erp_products_events_products_on_product_id"
  end

  create_table "erp_products_hkerp_products", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "hkerp_product_id"
    t.decimal "price", default: "0.0"
    t.integer "stock", default: 0
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_erp_products_hkerp_products_on_product_id"
  end

  create_table "erp_products_inventory_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "hot_name"
    t.boolean "archived", default: false
    t.integer "creator_id"
    t.integer "custom_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_erp_products_inventory_categories_on_creator_id"
  end

  create_table "erp_products_inventory_products", id: :serial, force: :cascade do |t|
    t.string "image_url"
    t.string "name"
    t.decimal "price", default: "1.0"
    t.string "gift"
    t.string "product_link"
    t.integer "custom_order"
    t.string "hot_category_name"
    t.boolean "is_stock", default: true
    t.boolean "archived", default: false
    t.integer "inventory_category_id"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_erp_products_inventory_products_on_creator_id"
    t.index ["inventory_category_id"], name: "index_erp_products_inventory_products_on_inventory_category_id"
  end

  create_table "erp_products_manufacturings", id: :serial, force: :cascade do |t|
    t.string "code"
    t.datetime "manufacturing_date"
    t.integer "quantity", default: 1
    t.boolean "is_auto_reduce_part_quantity", default: true
    t.text "note"
    t.string "status"
    t.integer "product_id"
    t.integer "responsible_id"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_erp_products_manufacturings_on_creator_id"
    t.index ["product_id"], name: "index_erp_products_manufacturings_on_product_id"
    t.index ["responsible_id"], name: "index_erp_products_manufacturings_on_responsible_id"
  end

  create_table "erp_products_price_lists", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "valid_from"
    t.datetime "valid_to"
    t.boolean "active", default: true
    t.boolean "all_warehouses", default: true
    t.boolean "all_users", default: true
    t.boolean "all_contact_groups", default: true
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_erp_products_price_lists_on_creator_id"
  end

  create_table "erp_products_price_lists_users", id: :serial, force: :cascade do |t|
    t.integer "price_list_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["price_list_id"], name: "index_erp_products_price_lists_users_on_price_list_id"
    t.index ["user_id"], name: "index_erp_products_price_lists_users_on_user_id"
  end

  create_table "erp_products_price_lists_warehouses", id: :serial, force: :cascade do |t|
    t.integer "price_list_id"
    t.integer "warehouse_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["price_list_id"], name: "index_erp_products_price_lists_warehouses_on_price_list_id"
    t.index ["warehouse_id"], name: "index_erp_products_price_lists_warehouses_on_warehouse_id"
  end

  create_table "erp_products_product_images", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.string "image_url"
    t.datetime "created_at", default: "2020-10-20 04:21:05", null: false
    t.datetime "updated_at", default: "2020-10-20 04:21:05", null: false
    t.text "description"
    t.boolean "is_main", default: false
    t.index ["product_id"], name: "index_erp_products_product_images_on_product_id"
  end

  create_table "erp_products_products", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "barcode"
    t.decimal "price", default: "1.0"
    t.decimal "cost", default: "0.0"
    t.decimal "on_hand", default: "0.0"
    t.decimal "weight", default: "0.0"
    t.decimal "volume", default: "0.0"
    t.decimal "stock_min", default: "0.0"
    t.decimal "stock_max", default: "999999.0"
    t.text "description"
    t.text "short_description"
    t.boolean "is_deal", default: false
    t.boolean "is_new", default: false
    t.boolean "is_bestseller", default: false
    t.boolean "is_business_choices", default: false
    t.boolean "is_top_business_choices", default: false
    t.decimal "deal_price"
    t.integer "deal_percent"
    t.integer "brand_id"
    t.integer "accessory_id"
    t.text "events_note"
    t.text "meta_keywords"
    t.text "meta_description"
    t.datetime "deal_from_date"
    t.datetime "deal_to_date"
    t.text "internal_note"
    t.boolean "can_be_sold", default: true
    t.boolean "can_be_purchased", default: true
    t.boolean "is_for_pos", default: true
    t.boolean "point_enabled", default: true
    t.boolean "archived", default: false
    t.integer "category_id"
    t.integer "unit_id"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_name"
    t.string "product_intro_link"
    t.text "cache_search"
    t.boolean "is_stock_inventory", default: false
    t.string "alias"
    t.boolean "is_sold_out", default: false
    t.text "cache_properties"
    t.integer "cache_stock"
    t.boolean "is_call", default: false
    t.text "description_2"
    t.index ["accessory_id"], name: "index_erp_products_products_on_accessory_id"
    t.index ["brand_id"], name: "index_erp_products_products_on_brand_id"
    t.index ["category_id"], name: "index_erp_products_products_on_category_id"
    t.index ["creator_id"], name: "index_erp_products_products_on_creator_id"
    t.index ["unit_id"], name: "index_erp_products_products_on_unit_id"
  end

  create_table "erp_products_products_gifts", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "gift_id"
    t.integer "quantity", default: 1
    t.decimal "price", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gift_id"], name: "index_erp_products_products_gifts_on_gift_id"
    t.index ["product_id"], name: "index_erp_products_products_gifts_on_product_id"
  end

  create_table "erp_products_products_parts", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "part_id"
    t.integer "quantity", default: 1
    t.decimal "total", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_id"], name: "index_erp_products_products_parts_on_part_id"
    t.index ["product_id"], name: "index_erp_products_products_parts_on_product_id"
  end

  create_table "erp_products_products_units", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "unit_id"
    t.decimal "conversion_value", default: "1.0"
    t.decimal "price", default: "0.0"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_erp_products_products_units_on_product_id"
    t.index ["unit_id"], name: "index_erp_products_products_units_on_unit_id"
  end

  create_table "erp_products_products_values", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "properties_value_id"
    t.index ["product_id"], name: "index_erp_products_products_values_on_product_id"
    t.index ["properties_value_id"], name: "index_erp_products_products_values_on_properties_value_id"
  end

  create_table "erp_products_properties", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archived", default: false
    t.integer "property_group_id"
    t.boolean "is_show_list"
    t.boolean "is_show_detail"
    t.integer "custom_order", default: 0
    t.boolean "is_show_website", default: false
    t.index ["creator_id"], name: "index_erp_products_properties_on_creator_id"
    t.index ["property_group_id"], name: "index_erp_products_properties_on_property_group_id"
  end

  create_table "erp_products_properties_values", id: :serial, force: :cascade do |t|
    t.integer "property_id"
    t.string "value"
    t.boolean "is_show_website", default: false
    t.index ["property_id"], name: "index_erp_products_properties_values_on_property_id"
  end

  create_table "erp_products_property_groups", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "archived", default: false
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "custom_order", default: 0
    t.index ["creator_id"], name: "index_erp_products_property_groups_on_creator_id"
  end

  create_table "erp_products_ratings", id: :serial, force: :cascade do |t|
    t.text "content"
    t.integer "star"
    t.boolean "archived", default: true
    t.integer "product_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_erp_products_ratings_on_product_id"
    t.index ["user_id"], name: "index_erp_products_ratings_on_user_id"
  end

  create_table "erp_products_state_check_details", force: :cascade do |t|
    t.integer "quantity", default: 1
    t.text "note"
    t.bigint "state_id"
    t.bigint "product_id"
    t.bigint "state_check_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "old_state_id"
    t.index ["old_state_id"], name: "index_erp_products_state_check_details_on_old_state_id"
    t.index ["product_id"], name: "index_erp_products_state_check_details_on_product_id"
    t.index ["state_check_id"], name: "index_erp_products_state_check_details_on_state_check_id"
    t.index ["state_id"], name: "index_erp_products_state_check_details_on_state_id"
  end

  create_table "erp_products_state_checks", force: :cascade do |t|
    t.string "code"
    t.datetime "check_date"
    t.text "note"
    t.string "status", default: "draft"
    t.boolean "archived", default: false
    t.bigint "warehouse_id"
    t.bigint "employee_id"
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "confirmed_at"
    t.index ["creator_id"], name: "index_erp_products_state_checks_on_creator_id"
    t.index ["employee_id"], name: "index_erp_products_state_checks_on_employee_id"
    t.index ["warehouse_id"], name: "index_erp_products_state_checks_on_warehouse_id"
  end

  create_table "erp_products_states", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "status", default: "draft"
    t.boolean "archived", default: false
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_erp_products_states_on_creator_id"
  end

  create_table "erp_products_stock_check_details", id: :serial, force: :cascade do |t|
    t.integer "quantity", default: 1
    t.text "note"
    t.integer "product_id"
    t.integer "stock_check_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "state_id"
    t.integer "real"
    t.integer "stock"
    t.index ["product_id"], name: "index_erp_products_stock_check_details_on_product_id"
    t.index ["state_id"], name: "index_erp_products_stock_check_details_on_state_id"
    t.index ["stock_check_id"], name: "index_erp_products_stock_check_details_on_stock_check_id"
  end

  create_table "erp_products_stock_checks", id: :serial, force: :cascade do |t|
    t.string "code"
    t.datetime "adjustment_date"
    t.text "description"
    t.string "status"
    t.boolean "archived", default: false
    t.integer "creator_id"
    t.integer "warehouse_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.datetime "confirmed_at"
    t.index ["creator_id"], name: "index_erp_products_stock_checks_on_creator_id"
    t.index ["employee_id"], name: "index_erp_products_stock_checks_on_employee_id"
    t.index ["warehouse_id"], name: "index_erp_products_stock_checks_on_warehouse_id"
  end

  create_table "erp_products_units", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "archived", default: false
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_erp_products_units_on_creator_id"
  end

  create_table "erp_products_vendor_taxes", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "tax_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_erp_products_vendor_taxes_on_product_id"
    t.index ["tax_id"], name: "index_erp_products_vendor_taxes_on_tax_id"
  end

  create_table "erp_quick_orders_order_details", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "order_id"
    t.string "product_name"
    t.integer "quantity", default: 1
    t.decimal "price"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_erp_quick_orders_order_details_on_order_id"
    t.index ["product_id"], name: "index_erp_quick_orders_order_details_on_product_id"
  end

  create_table "erp_quick_orders_orders", force: :cascade do |t|
    t.string "code"
    t.string "customer_name"
    t.string "phone"
    t.string "email"
    t.text "note"
    t.decimal "cache_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "invoice", default: false
    t.string "address"
    t.bigint "district_id"
    t.bigint "state_id"
    t.index ["district_id"], name: "index_erp_quick_orders_orders_on_district_id"
    t.index ["state_id"], name: "index_erp_quick_orders_orders_on_state_id"
  end

  create_table "erp_testimonials_testimonials", id: :serial, force: :cascade do |t|
    t.string "logo"
    t.string "author"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "workplace"
    t.boolean "archived", default: false
  end

  create_table "erp_user_groups", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "permissions"
    t.bigint "creator_id"
    t.boolean "active", default: true
    t.index ["creator_id"], name: "index_erp_user_groups_on_creator_id"
  end

  create_table "erp_users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.boolean "backend_access", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "avatar"
    t.string "timezone"
    t.boolean "active", default: false
    t.integer "creator_id"
    t.text "permissions"
    t.string "confirmation_token"
    t.datetime "confirmed_at", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "confirmation_sent_at"
    t.bigint "user_group_id"
    t.string "address"
    t.text "data"
    t.text "cache_search"
    t.index ["confirmation_token"], name: "index_erp_users_on_confirmation_token", unique: true
    t.index ["creator_id"], name: "index_erp_users_on_creator_id"
    t.index ["email"], name: "index_erp_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_erp_users_on_reset_password_token", unique: true
    t.index ["user_group_id"], name: "index_erp_users_on_user_group_id"
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.integer "transaction_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

end
