module Erp
  module Locyen
    module Frontend
      class ShoppingCartController < Erp::Frontend::FrontendController
        def top_cart
          render partial: 'erp/locyen/frontend/shopping_cart/top_cart'
        end
      end
    end
  end
end