class AddMethodsToErpQuickOrdersOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :erp_quick_orders_orders, :shipping_method, :string
    add_column :erp_quick_orders_orders, :payment_method, :string
  end
end
