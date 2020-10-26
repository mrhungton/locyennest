class CreateErpMenusMenusProductsCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_menus_menus_products_categories do |t|
      t.references :menu, index: true, references: :erp_menus_menus
      t.references :category, index: true, references: :erp_products_categories

      t.timestamps
    end
  end
end