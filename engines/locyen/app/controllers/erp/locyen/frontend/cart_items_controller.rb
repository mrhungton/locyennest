module Erp
  module Locyen
    module Frontend
      class CartItemsController < Erp::Frontend::FrontendController
        # POST /cart_items
        # POST /cart_items.json
        def add_to_cart
          quantity = params[:quantity]
          product = Erp::Products::Product.find(params[:product_id])
          @cart_item = @cart.add_product(product.id, quantity)

          if @cart_item.save
            render plain: "Sản phẩm \"#{product.name}\" đã được thêm vào giỏ hàng."
          end
        end

        def remove_cart_item
          @cart.remove_cart_item(params[:cart_item_id])
          redirect_to erp_locyen.shopping_cart_path, notice: 'Xóa sản phẩm khỏi giỏ hàng thành công.'
        end
      end
    end
  end
end
