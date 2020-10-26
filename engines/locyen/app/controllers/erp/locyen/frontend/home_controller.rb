module Erp
  module Locyen
    module Frontend
      class HomeController < Erp::Frontend::FrontendController
        def index
          @sliders = Erp::Banners::Banner.get_home_sliders.order('erp_banners_banners.custom_order asc')
          @certificates = Erp::Banners::Banner.get_certificates.order('erp_banners_banners.custom_order asc')
          @about = Erp::Articles::Article.get_all_home_abouts.last
          @testimonials = Erp::Testimonials::Testimonial.get_testimonials
          @bestseller_products = Erp::Products::Product.get_bestseller_products.order(:created_at)
          # @newest_products = Erp::Products::Product.get_newest_products.order(:created_at)
          @newest_blogs = Erp::Articles::Article.newest_articles(5).order(:created_at)
          @categories = Erp::Menus::Menu.get_menus.order(:custom_order)
        end
      end
    end
  end
end
