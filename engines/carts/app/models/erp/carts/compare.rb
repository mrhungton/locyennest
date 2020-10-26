module Erp::Carts
  class Compare < ApplicationRecord
    has_many :compare_items, dependent: :destroy      
    
    def get_number_items
      self.compare_items.count
    end
    
    def remove_compare_item(compare_item_id)
      self.compare_items.where(id: compare_item_id).destroy_all
    end
  end
end
