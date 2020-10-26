module Erp::Carts
  class Cart < ApplicationRecord
    has_many :cart_items, dependent: :destroy
    
    # add product - smarter cart
    def add_product(product_id, quantity)
      current_item = cart_items.find_by(product_id: product_id)
      if !current_item.present?
        current_item = cart_items.build(product_id: product_id, quantity: 0)
      end
      if quantity.present?
        current_item.quantity += quantity.to_i  
      else
        current_item.quantity += 1
      end
        current_item
    end
    
    # remove cart item
    def remove_cart_item(cart_item_id)
      self.cart_items.where(id: cart_item_id).destroy_all
    end
    
    # total price - all cart items
    def total_order
      amount = 0.0
      self.cart_items.each do |od|
        amount += od.total_price
      end
      
      return amount
    end
    
  end
end
