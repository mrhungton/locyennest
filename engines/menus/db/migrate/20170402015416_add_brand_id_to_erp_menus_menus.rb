class AddBrandIdToErpMenusMenus < ActiveRecord::Migration[5.0]
  def change
    add_column :erp_menus_menus, :brand_id, :integer
  end
end