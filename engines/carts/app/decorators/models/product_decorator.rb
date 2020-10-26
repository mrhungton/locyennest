Erp::Products::Product.class_eval do
  has_many :cart_items, class_name: 'Erp::Carts::CartItem'
	before_destroy :ensure_not_referenced_by_any_cart_item
	
  private
    # ensure that there are no cart items referencing this product
    def ensure_not_referenced_by_any_cart_item
      if cart_items.empty?
        return true
      else
        errors.add(:base, "Cart Items present")
        return false
      end
    end
end
