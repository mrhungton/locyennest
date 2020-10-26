module Erp
  module Locyen
    module Frontend
      class AboutUsController < Erp::Frontend::FrontendController
        def index
          @abouts = Erp::Articles::Article.get_all_about_us
        end
      end
    end
  end
end
  