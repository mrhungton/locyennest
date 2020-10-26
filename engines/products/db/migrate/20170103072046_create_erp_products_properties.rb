class CreateErpProductsProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_products_properties do |t|
      t.string :name
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
