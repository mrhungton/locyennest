class AddIsShowDetailAndNumberPerPageToErpMenusMenus < ActiveRecord::Migration[5.0]
  def change
    add_column :erp_menus_menus, :is_show_detail, :boolean, default: true
    add_column :erp_menus_menus, :number_per_page, :integer, default: 12
  end
end
