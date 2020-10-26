class AddImageMenuToErpMenusMenus < ActiveRecord::Migration[5.0]
  def change
    add_column :erp_menus_menus, :image_menu, :string
    add_column :erp_menus_menus, :image_menu_title, :string
    add_column :erp_menus_menus, :image_menu_link, :string
  end
end
