module Erp
  module Locyen
    module Frontend
      class QuickOrderController < Erp::Frontend::FrontendController
        def quick_order
          if params[:product_id].present?
            quantity = 1
            product = Erp::Products::Product.find(params[:product_id])
            @cart_item = @cart.add_product(product.id, quantity)
            @cart.cart_items << @cart_item
          end

          if @cart.cart_items.empty?
            redirect_to erp_locyen.root_path, notice: "Chưa có sản phẩm nào được chọn."
            return
          end
          
          @quick_order = Erp::QuickOrders::Order.new
      
          if params[:quick_order].present?
            @quick_order = Erp::QuickOrders::Order.new(quick_order_params)
            if @quick_order.save
              @quick_order.save_from_cart(@cart)
              Erp::Carts::Cart.destroy(session[:cart_id])
              
              # Erp::QuickOrders::QuickOrderMailer.sending_admin_email_order_confirmation(@quick_order).deliver_now
              # Erp::QuickOrders::QuickOrderMailer.sending_customer_email_order_confirmation(@quick_order).deliver_now

              redirect_to erp_locyen.checkout_completed_path, notice: "Thông tin đặt hàng được gửi thành công."
            else
              redirect_back(fallback_location: @quick_order, notice: "Thông tin đặt hàng chưa được gửi. Vui lòng kiểm tra và thử lại?")
            end
          end
          if request.xhr?
            render layout: nil
          end
        end

        private
          def quick_order_params
            params.fetch(:quick_order, {}).permit(:customer_name, :phone, :email, :address, :note, :invoice)
          end
      end
    end
  end
end
