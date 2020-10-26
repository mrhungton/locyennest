module Erp::Articles
  class Article < ApplicationRecord
		include Erp::CustomOrder
		
    belongs_to :creator, class_name: "Erp::User"
    belongs_to :category
    has_many :comments, class_name: "Erp::Articles::Comment", dependent: :destroy
    mount_uploader :image, Erp::Articles::ArticleUploader

    # get articles active
    def self.get_active
			self.where(archived: false)
		end

    # Filters
    def self.filter(query, params)
      params = params.to_unsafe_hash
      and_conds = []

      # show archived items condition - default: false
			#show_archived = false

			#filters
			if params["filters"].present?
				params["filters"].each do |ft|
					or_conds = []
					ft[1].each do |cond|
						# in case filter is show archived
						#if cond[1]["name"] == 'show_archived'
							# show archived items
							#show_archived = true
						#else
							or_conds << "#{cond[1]["name"]} = '#{cond[1]["value"]}'"
						#end
					end
					and_conds << '('+or_conds.join(' OR ')+')' if !or_conds.empty?
				end
			end

      #keywords
      if params["keywords"].present?
        params["keywords"].each do |kw|
          or_conds = []
          kw[1].each do |cond|
            or_conds << "LOWER(#{cond[1]["name"]}) LIKE '%#{cond[1]["value"].downcase.strip}%'"
          end
          and_conds << '('+or_conds.join(' OR ')+')'
        end
      end

      # join with categories table for search with category
      query = query.joins(:category)
      
      # global filter
      global_filter = params[:global_filter]
      if global_filter.present?
				if global_filter[:category_id].present?
					query = query.where(category_id: global_filter[:category_id])
				end
			end

      # join with users table for search creator
      query = query.joins(:creator)

      # showing archived items if show_archived is not true
			#query = query.where(archived: false) if show_archived == false

      query = query.where(and_conds.join(' AND ')) if !and_conds.empty?

      return query
    end

    def self.search(params)
      query = self.all
      query = self.filter(query, params)

      # order
      if params[:sort_by].present?
        order = params[:sort_by]
        order += " #{params[:sort_direction]}" if params[:sort_direction].present?

        query = query.order(order)
      end

      return query
    end

    # data for dataselect ajax
    def self.dataselect(keyword='')
      query = self.all

      if keyword.present?
        keyword = keyword.strip.downcase
        query = query.where('LOWER(name) LIKE ?', "%#{keyword}%")
      end

      query = query.limit(8).map{|article| {value: article.id, text: article.name} }
    end

    def archive
			update_columns(archived: true)
		end

		def unarchive
			update_columns(archived: false)
		end

    def self.archive_all
			update_all(archived: true)
		end

    def self.unarchive_all
			update_all(archived: false)
		end

    def category_id
      category.present? ? category.id : ''
    end

    def category_name
      category.present? ? category.name : ''
    end

    def post_by
			creator.present? ? creator.name : ''
		end

    # get all blogs
    def self.get_all_blogs(params)
			query = self.get_active
			if params[:cat_id].present?
				query = query.where(category_id: params[:cat_id])
			else
				query = query.joins(:category).where('erp_articles_categories.alias = ?', Erp::Articles::Category::ALIAS_BLOG)
			end
			query = query.order('erp_articles_articles.created_at DESC')
    end

    # get newest articles
    def self.newest_articles(limit=nil)
			records = self.get_active.order('erp_articles_articles.created_at DESC')
			records = records.joins(:category).where("erp_articles_categories.alias = ?", Erp::Articles::Category::ALIAS_BLOG).limit(limit)
		end

    # get terms and conditions
    def self.get_terms_and_conditions
			self.joins(:category).where("erp_articles_categories.alias = ?", Erp::Articles::Category::ALIAS_TERMS_CONDITIONS)
		end

    # get terms and conditions
    def self.get_faqs
			self.joins(:category).where("erp_articles_categories.alias = ?", Erp::Articles::Category::ALIAS_FAQ)
		end

    # get tags
    def get_tags
			tags.to_s.split(/[\,\;]/).select {|c| c.present? }
		end
  end
end
