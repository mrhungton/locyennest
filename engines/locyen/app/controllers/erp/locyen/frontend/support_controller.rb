module Erp
  module Locyen
    module Frontend
      class SupportController < Erp::Frontend::FrontendController
        def faq
          @body_class = "res layout-subpage"
          @faqs = Erp::Articles::Article.get_faqs
        end
        
        def policy
          @categories = Erp::Articles::Category.get_categories_by_alias_group
          @article = Erp::Articles::Category.find(params[:category_id]).articles.last
        end
    
        def terms_and_conditions
          @terms_conditions = Erp::Articles::Article.get_terms_and_conditions
        end
    
        def site_map
          # @body_class = "res layout-subpage"
        end
      end
    end
  end
end
