class AddUseFilterToErpMenusMenus < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_menus_menus, :use_filter, :boolean, default: false
  end
end
