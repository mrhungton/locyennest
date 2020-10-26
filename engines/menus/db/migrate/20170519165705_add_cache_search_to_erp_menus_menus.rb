class AddCacheSearchToErpMenusMenus < ActiveRecord::Migration[5.0]
  def change
    add_column :erp_menus_menus, :cache_search, :text
  end
end
