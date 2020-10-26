class CreateErpCartsCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_carts_cart_items do |t|
      t.integer :quantity, default: 1
      t.references :product, index: true, references: :erp_products_products
      t.belongs_to :cart, index: true, belongs_to: :erp_carts_carts

      t.timestamps
    end
  end
end