module Erp::Carts
  class CartItem < ApplicationRecord
    belongs_to :product, class_name: "Erp::Products::Product"
    belongs_to :cart
    
    def product_name
      product.present? ? product.short_name : ''
    end
    
    def product_price
      product.present? ? product.product_price : ''
    end
    
    def total_price
      product.product_price*quantity
    end
    
    def self.number_items
      count = 0
      self.all.each do |item|
        count += item.quantity
      end
      
      return count
    end 
    
  end
end
