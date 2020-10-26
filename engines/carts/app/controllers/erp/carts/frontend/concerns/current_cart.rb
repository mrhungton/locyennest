module Erp
  module Carts
    module Frontend
      module Concerns
        module CurrentCart
          extend ActiveSupport::Concern
          
          private
            def set_cart
              @cart = Erp::Carts::Cart.find(session[:cart_id])
            rescue ActiveRecord::RecordNotFound
              @cart = Erp::Carts::Cart.create
              session[:cart_id] = @cart.id
            end
        end
      end
    end
  end
end