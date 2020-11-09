module Erp
    module Locyen
      module Frontend
        class SearchController < Erp::Frontend::FrontendController
          include Erp::Locyen::ApplicationHelper
  
          # Search page
          def search
            @keyword = params[:keyword]
            @products = Erp::Products::Product.search(params).paginate(:page => params[:page], :per_page => 32)
            @articles = Erp::Articles::Article.search(params).paginate(:page => params[:page], :per_page => 32)
          end
        end
      end
    end
  end