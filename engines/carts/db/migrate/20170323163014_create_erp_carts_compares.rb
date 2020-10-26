class CreateErpCartsCompares < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_carts_compares do |t|

      t.timestamps
    end
  end
end
