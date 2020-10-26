module Erp::Menus
  class Menu < ApplicationRecord
		include Erp::CustomOrder
		mount_uploader :image_url_1, Erp::Menus::MenuImageUploader
		mount_uploader :image_url_2, Erp::Menus::MenuImageUploader
		mount_uploader :menu_icon, Erp::Menus::MenuImageUploader
		mount_uploader :image_menu, Erp::Menus::MenuImageUploader

    validates :name, :presence => true
    belongs_to :creator, class_name: "Erp::User"
    belongs_to :parent, class_name: "Erp::Menus::Menu", optional: true
    has_many :children, -> { order(custom_order: :asc) }, class_name: "Erp::Menus::Menu", foreign_key: "parent_id"
    has_many :related_menus, foreign_key: "parent_id", inverse_of: :parent, dependent: :destroy
    accepts_nested_attributes_for :related_menus, :reject_if => lambda { |a| a[:menu_id].blank? }, :allow_destroy => true

    if Erp::Core.available?("products")
			has_and_belongs_to_many :categories, class_name: "Erp::Products::Category"
			belongs_to :brand_group, class_name: "Erp::Products::BrandGroup", optional: true
			belongs_to :brand, class_name: "Erp::Products::Brand", foreign_key: "brand_id", optional: true

			# display brand group name
			def brand_group_name
				brand_group.present? ? brand_group.name : ''
			end

			def get_brand_groups
				brand_group.brand_group_details
			end

			# display brand name
			def brand_name
				brand.present? ? brand.name : ''
			end
		end

    STYLE_COLOR_1 = 'supper1'
    STYLE_COLOR_2 = 'supper2'
    STYLE_COLOR_3 = 'supper3'

    after_save :update_level

    def self.get_style_color_options()
      [
				{text: '', value: ''},
        {text: I18n.t('erp_menus_menus.dark_cyan'), value: STYLE_COLOR_1},
        {text: I18n.t('erp_menus_menus.outrageous_orange'), value: STYLE_COLOR_2},
        {text: I18n.t('erp_menus_menus.fruit_salad'), value: STYLE_COLOR_3}
      ]
    end

    def self.get_active
			self.where(archived: false).order("custom_order ASC")
		end

    def self.is_hot
			self.where(is_hot: true)
		end

    def self.get_hot_menus
			self.get_active.where(is_hot: true)
			               .where(parent_id: nil)
		end

    def self.get_menus
			self.get_active.where(parent_id: nil)
		end

    # Filters
    def self.filter(query, params)
      params = params.to_unsafe_hash
      and_conds = []

      # show archived items condition - default: false
			show_archived = false

			#filters
			if params["filters"].present?
				params["filters"].each do |ft|
					or_conds = []
					ft[1].each do |cond|
						# in case filter is show archived
						if cond[1]["name"] == 'show_archived'
							# show archived items
							show_archived = true
						else
							if cond[1]["value"] == 'nil'
								or_conds << "#{cond[1]["name"]} IS NULL"
							else
								or_conds << "#{cond[1]["name"]} = '#{cond[1]["value"]}'"
							end
						end
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

      # join with users table for search creator
      query = query.joins(:creator)

      # join with parent menu for search menu
      query = query.joins("LEFT JOIN erp_menus_menus parents_erp_menus_menus ON parents_erp_menus_menus.id = erp_menus_menus.parent_id")

      # showing archived items if show_archived is not true
			query = query.where(archived: false) if show_archived == false

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

      query = query.limit(8).map{|menu| {value: menu.id, text: (menu.parent_name.empty? ? '' : "#{menu.parent_name} / ") + menu.name.to_s} }
    end

    def full_name
      (self.parent_name.empty? ? '' : "#{self.parent_name} / ") + self.name.to_s
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

    # display name
    def parent_name
			parent.present? ? parent.name : ''
		end

    # get self and children ids
    def get_self_and_children_ids
      ids = [self.id]
      ids += get_children_ids_recursive
      return ids
		end

    # get children ids recursive
    def get_children_ids_recursive
      ids = []
      children.each do |c|
				if !c.children.empty?
					ids += c.get_children_ids_recursive
				end
				ids << c.id
			end
      return ids
		end

    def get_same_level_menus
			return self.parent.nil? ? Menu.where(level: 1) : self.parent.children
		end

    def get_related_sidebar_menus
			if self.children.empty?
				{
					menus: self.get_same_level_menus,
					parent: (self.get_same_level_menus.empty? or self.get_same_level_menus.first.parent.nil?) ? 'Chuyên mục' : self.get_same_level_menus.first.parent
				}
			else
				{
					menus: self.children,
					parent: self
				}
			end
		end

    if Erp::Core.available?("products")
			def get_products_for_categories(params)
				records = Erp::Products::Product.get_active
													.where(category_id: self.get_all_related_category_ids)

				if params[:exclude_product_id].present?
					records = records.where.not(id: params[:exclude_product_id])
				end

				# filter by brand if menu hass brand
				if self.brand_id.present?
					records = records.where(brand_id: self.brand_id)
				end

				if params[:brand_ids].present?
					records = records.where(brand_id: params[:brand_ids])
				end

				if params[:brand_id].present?
					records = records.where(brand_id: params[:brand_id])
				end
				
				if params[:property_value_ids].present?
					params.to_unsafe_hash[:property_value_ids].each do |row|
						records = records.where(id: Erp::Products::ProductsValue.select(:product_id)
														  .where(properties_value_id: row[1]))
					end
        end
				
				if params[:price_list].present?
          ors = []
          params[:price_list].each do |str|
            ors << "erp_products_products.price >= #{str.split('-')[0]} AND
                   erp_products_products.price <= #{str.split('-')[1]}"                                                                              
          end
          records = records.where(ors.join(" OR "))
        end

				if params[:is_business_choises].present?
					records = records.where(is_business_choices: true)
				end

				if params[:is_deal].present?
					records = records.where(is_deal: true)
				end

				if params[:is_bestseller].present?
					records = records.where(is_bestseller: true)
        end
        
        if params[:is_new].present?
					records = records.where(is_new: true)
				end

				if params[:sort_by].present?
					records = records.order(params[:sort_by].gsub('_', ' '))
				else
					records = records.order("created_at DESC")
				end				

				return records
			end

			def get_products
				records = Erp::Products::Product.get_active
													.where(category_id: self.get_all_related_category_ids)

				return records
			end

			def get_all_related_category_ids
				category_ids = []
				menu_ids = self.get_self_and_children_ids
				menu_ids.each do |menu_id|
					menu = Menu.find(menu_id)
					menu.categories.each do |category|
						category_ids += category.get_self_and_children_ids
					end
				end
				return category_ids.uniq
			end
		end

    # init custom order
    def init_custom_order
			self.update_column(:custom_order, self.class.maximum("custom_order").to_i + 1)
		end

    # update level
    def update_level
			level = 1
			parent = self.parent
			while parent.present?
				level += 1
				parent = parent.parent
			end

			self.update_column(:level, level)
		end

    # get self parent menus
    def self_and_parent_menus(options={})
			arr = [self]
			father = self.parent
			while father.present?
				arr << father
				father = father.parent
			end

			return arr.reverse
		end

    # Get child menus array
    def get_children_array
			arr = []
			self.children.get_active.each do |child_1|
				arr << {menu: child_1, class: 'parent'}
				child_1.children.get_active.each do |child_2|
					arr << {menu: child_2, class: 'child'}
				end
			end
			arr
		end

    # get all brands for menu
    def brands
			Erp::Products::Brand.where(id: self.get_products_for_categories({}).select(:brand_id).where.not(brand_id: nil)).order(:name)
		end
    
    def count_keywords_arr
      arr = self.meta_keywords.split(', ') if self.meta_keywords.present?
      return arr.count
    end    

    # search by keyword
    def self.filter_by_keyword(kw)
			query = self.where("1=1")
			# single keyword
      if kw.present?
				keyword = kw.strip.downcase
				keyword.split(' ').each do |q|
					q = q.strip
					query = query.where('LOWER(cache_search) LIKE ?', '%'+q+'%')
				end
			end

      return query
		end
        
    def menu_get_properties_array
			if (self.categories.count > 0)
				self.categories.first.category_get_properties_array
			end
		end

    # select result
    def self.select2(params=nil, limit=40)
			query = self.order('name asc')
			query = query.filter_by_keyword(params[:q]) if params[:q].present?
			query = query.limit(limit)

			return query.map{|menu| {value: menu.id, text: menu.name}}
		end

    # Update cache search for menus
    after_save :update_cache_search

		def update_cache_search
			str = []
			str << name.to_s.downcase.strip

			self.update_column(:cache_search, str.join(" ") + " " + str.join(" ").to_ascii)
		end
  end
end
