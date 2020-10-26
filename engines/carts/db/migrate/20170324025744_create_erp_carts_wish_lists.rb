class CreateErpCartsWishLists < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_carts_wish_lists do |t|
      t.references :product, index: true, references: :erp_products_products
      t.belongs_to :user, index: true, belongs_to: :erp_users

      t.timestamps
    end
  end
end
