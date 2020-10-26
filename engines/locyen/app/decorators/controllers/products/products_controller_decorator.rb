Erp::Products::Backend::ProductsController.class_eval do
  before_action :set_product, only: [:check_is_published, :uncheck_is_published, :check_is_bestseller, :uncheck_is_bestseller, 
    :check_is_new, :uncheck_is_new, :check_is_call, :uncheck_is_call, :product_details, :archive, :unarchive, :show, :edit, :update]
  before_action :set_products, only: [:delete_all, :archive_all, :unarchive_all, :check_is_bestseller_all, :uncheck_is_bestseller_all, 
    :check_is_new_all, :uncheck_is_new_all, :check_is_call_all, :uncheck_is_call_all, :check_is_published_all, :uncheck_is_published_all]
    
  # # Check_is_published /products/published?id=1
  # def check_is_published
  #   @product.check_is_published

  #   respond_to do |format|
  #   format.json {
  #     render json: {
  #     'message': t('.success'),
  #     'type': 'success'
  #     }
  #   }
  #   end
  # end

  # # Uncheck_is_published /products/published?id=1
  # def uncheck_is_published
  #   @product.uncheck_is_published

  #   respond_to do |format|
  #   format.json {
  #     render json: {
  #     'message': t('.success'),
  #     'type': 'success'
  #     }
  #   }
  #   end
  # end

  # # Check_is_published_all /products/published?ids=1,2,3
  # def check_is_published_all
  #   @products.check_is_published_all

  #   respond_to do |format|
  #     format.json {
  #       render json: {
  #         'message': t('.success'),
  #         'type': 'success'
  #       }
  #     }
  #   end
  # end

  # # Check_is_published_all /products/published?ids=1,2,3
  # def uncheck_is_published_all
  #   @products.uncheck_is_published_all

  #   respond_to do |format|
  #     format.json {
  #       render json: {
  #         'message': t('.success'),
  #         'type': 'success'
  #       }
  #     }
  #   end
  # end

  # Check_is_new /products/new?id=1
  def check_is_new
    @product.check_is_new

    respond_to do |format|
    format.json {
      render json: {
      'message': t('.success'),
      'type': 'success'
      }
    }
    end
  end

  # Uncheck_is_new /products/new?id=1
  def uncheck_is_new
    @product.uncheck_is_new

    respond_to do |format|
    format.json {
      render json: {
      'message': t('.success'),
      'type': 'success'
      }
    }
    end
  end

  # Check_is_new_all /products/new?ids=1,2,3
  def check_is_new_all
    @products.check_is_new_all

    respond_to do |format|
      format.json {
        render json: {
          'message': t('.success'),
          'type': 'success'
        }
      }
    end
  end

  # Check_is_new_all /products/new?ids=1,2,3
  def uncheck_is_new_all
    @products.uncheck_is_new_all

    respond_to do |format|
      format.json {
        render json: {
          'message': t('.success'),
          'type': 'success'
        }
      }
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def product_params
      params.fetch(:product, {}).permit(
        :code, :name, :short_name,
        :price, :cost, :on_hand, :weight, :volume, :unit_id,
        :product_type_id, :brand_id, :product_model_id, 
        :model_from_year, :model_to_year,
        :length, :width, :thickness, :tinting,
        # frontend
        :product_intro_link, :short_description,
        :is_call, :is_bestseller, :is_sold_out, :is_new,
        :is_deal, :deal_price, :deal_percent, :deal_from_date, :deal_to_date, 
        :meta_keywords, :meta_description, :published,
        # end frontend
        :stock_min, :stock_max, :description, :description_2, :internal_note, :point_enabled, :category_id,
        customer_tax_ids: [], vendor_tax_ids: [],
        :product_images_attributes => [ :id, :image_url, :image_url_cache, :product_id, :description, :is_main, :_destroy ],
        :products_units_attributes => [ :id, :unit_id, :conversion_value, :price, :code, :product_id, :_destroy ],
        :products_parts_attributes => [ :id, :part_id, :quantity, :total, :product_id, :_destroy ],
        :products_gifts_attributes => [ :id, :gift_id, :quantity, :price, :product_id, :_destroy ]
      )
    end
end