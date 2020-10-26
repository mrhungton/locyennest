module Erp
    module Locyen
      module Frontend
        class BlogController < Erp::Frontend::FrontendController
          def index
            @blogs = Erp::Articles::Article.get_all_blogs(params).paginate(:page => params[:page], :per_page => 6)
            @categories = Erp::Articles::Category.get_categories_by_alias_blog
            @newest_blogs = Erp::Articles::Article.newest_articles(5)
            if params[:cat_id].present?
              @category = Erp::Articles::Category.find(params[:cat_id])
            end
          end

          def detail
            @blog = Erp::Articles::Article.find(params[:article_id])
            # @blog.increase_visit # cap nhat luot xem
            @meta_keywords = @blog.meta_keywords
            @meta_description = @blog.meta_description
            @categories = Erp::Articles::Category.get_categories_by_alias_blog
            @newest_blogs = Erp::Articles::Article.where.not(id: @blog.id).newest_articles(10)
          end
        end
      end
    end
  end
  