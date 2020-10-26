class CreateErpCartsCompareItems < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_carts_compare_items do |t|
      t.references :product, index: true, references: :erp_products_products
      t.belongs_to :compare, index: true, belongs_to: :erp_carts_compares
      
      t.timestamps
    end
  end
end
