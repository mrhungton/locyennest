class CreateErpMenusMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_menus_menus do |t|
      t.string :name
      t.integer :parent_id
      t.string :style_icon
      t.string :style_color
      t.string :image_url_1
      t.string :image_url_2
      t.string :menu_icon
      t.string :image_menu_link_1
      t.string :image_menu_link_2
      t.text :description
      t.text :meta_keywords
      t.text :meta_description
      t.boolean :is_hot, default: false
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users
      t.references :brand_group, index: true, references: :erp_products_brand_groups
      t.integer :custom_order
      t.integer :level

      t.timestamps
    end
  end
end
