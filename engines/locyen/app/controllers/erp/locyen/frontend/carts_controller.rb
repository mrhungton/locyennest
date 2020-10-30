module Erp
  module Locyen
    module Frontend
      class CartsController < Erp::Frontend::FrontendController
        rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
      
        # PATCH/PUT /carts/1
        # PATCH/PUT /carts/1.json
        def update
          params.to_unsafe_h[:quantities].each do |q|
            item = Erp::Carts::CartItem.find(q[0])
            if q[1].present? and q[1].to_i > 0
              item.update_attribute(:quantity, q[1])
            else
              item.destroy
            end
          end
          render json: {
            status: 'success',
            message: 'Cập nhật số lượng sản phẩm thành công.'
          }
          # redirect_to erp_locyen.shopping_cart_path, notice: 'Cập nhật số lượng sản phẩm thành công.'
        end
      
        private
        
          def invalid_cart
            logger.error "Không thể truy cập vào giỏ hàng này: #{params[:id]}"
            redirect_to erp_locyen.root_path, notice: 'Giỏ hàng không hợp lệ'
          end
      end
    end
  end
end