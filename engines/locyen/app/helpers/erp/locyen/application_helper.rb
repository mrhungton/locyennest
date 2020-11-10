module Erp
  module Locyen
    module ApplicationHelper
      def title(page_title)
        content_for :title, page_title.to_s
      end

      # display full address
      def full_address(obj)
        str = []
        str << obj.address if obj.address.present?
        str << obj.district_name if obj.district_name.present?
        str << obj.state_name if obj.state_name.present?
        str.join(", ")
      end

      # format price
      def format_price(price)
        price = (price.to_f/1000).round*1000 if Erp::Core.available?("locyen")
        "<span style=\'font-family:sans-serif;\'>#{number_to_currency(price, precision: 0, format: "%n₫", separator: ',', unit: '', delimiter: ".")}</span>".html_safe
      end

      # article link
      def article_link(article)
        erp_locyen.blog_detail_path(article_id: article.id, title: url_friendly(article.name))
      end

      # menu link
      def menu_link(menu)
        erp_locyen.category_path(menu_id: menu.id, category_name: url_friendly(menu.name))
      end

      # product link
      def product_link(product)
        erp_locyen.product_detail_path(product_id: product.id, product_name: product.alias)
      end

      # add to cart button
      def add_to_cart_button(product)
        "<button class=\"add-to-cart text-uppercase mtb-5\"
          data-url=\"#{erp_locyen.add_to_cart_frontend_cart_items_path}\"
          data-id=\"#{product.id}\" >
          <i class=\"fa fa-cart-plus\"></i> thêm vào giỏ hàng
        </button>".html_safe
      end
    end
  end
end
