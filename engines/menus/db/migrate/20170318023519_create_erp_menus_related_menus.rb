class CreateErpMenusRelatedMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_menus_related_menus do |t|
      t.references :parent, index: true, references: :erp_menus_menus
      t.references :menu, index: true, references: :erp_menus_menus
      
      t.timestamps
    end
  end
end
