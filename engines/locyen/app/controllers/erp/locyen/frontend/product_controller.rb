module Erp
  module Locyen
    module Frontend
      class ProductController < Erp::Frontend::FrontendController
        include Erp::Locyen::ApplicationHelper

        def index
          # @products = Erp::Products::Product.get_published_products.paginate(:page => params[:page], :per_page => 12)
          # @brands = Erp::Products::Brand.get_brands_order_name
          # # @meta_keywords = @menu.meta_keywords
          # # @meta_description = @menu.meta_description
          # if request.xhr?
          #   render layout: nil
          # end
        end
        
        def category
          # @body_class = "res layout-subpage"
          @menu = Erp::Menus::Menu.find(params[:menu_id])
          # @parent_menu = @menu.parent
          # @related_menus = @menu.related_menus.limit(5)
          @products = @menu.get_products_for_categories(params).paginate(:page => params[:page], :per_page => @menu.number_per_page)
          # @brands = Erp::Products::Brand.get_brands_order_name
          @meta_keywords = @menu.meta_keywords
          @meta_description = @menu.meta_description

          # if request.xhr?
          #   render layout: nil
          # end
          # expires_in 12.hours, public: true
        end

        def detail
          @product = Erp::Products::Product.find(params[:product_id])
          
          @related_products = Erp::Products::Product.get_active#.get_published_products
            .where.not(id: @product.id)
            .where(category_id: @product.category)
            .order('erp_products_products.created_at desc')
            .limit(15)

          @menu = params[:menu_id].present? ? Erp::Menus::Menu.find(params[:menu_id]) : @product.find_menu
          
          @meta_keywords = @product.meta_keywords
          @meta_description = @product.meta_description
          
          if @menu.present?
            if !@product.meta_keywords.present?
              @meta_keywords = @menu.meta_keywords
            end
            
            if !@product.meta_description.present?
              @meta_description = @menu.meta_description
            end
          end
        end
        
      end
    end
  end
end