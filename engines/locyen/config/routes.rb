# *** FRONT-END  ***
Erp::Locyen::Engine.routes.draw do
  scope "(:locale)", locale: /vi|en/ do
    root to: "frontend/home#index"
    # Infomation
    get "gioi-thieu" => "frontend/about_us#index", as: :about_us
    get "lien-he" => "frontend/contact_us#index", as: :contact_us
    post "lien-he" => "frontend/contact_us#index"

    # Blog
    get "goc-chia-se" => "frontend/blog#index", as: :blog
    get "goc-chia-se/:title-atc:article_id" => "frontend/blog#detail", as: :blog_detail
    get "goc-chia-se/chu-de/:title-c:cat_id" => "frontend/blog#index", as: :blog_with_category

    # Product
    # get "/san-pham" => "frontend/product#index", as: :product
    # get 'to-yen', to: 'frontend/product#category', defaults: { menu_id: 1 }
    # get 'yen-chung-tuoi', to: 'frontend/product#category', defaults: { menu_id: 2 }
    # get 'bo-qua-tang', to: 'frontend/product#category', defaults: { menu_id: 3 }
    get "/:category_name-cid:menu_id" => "frontend/product#category", as: :category
    get "/:product_name-pid:product_id" => "frontend/product#detail", as: :product_detail

    # Shopping cart
    get "top-cart" => "frontend/shopping_cart#top_cart", as: :top_cart
    get "gio-hang" => "frontend/shopping_cart#cart", as: :shopping_cart
    get "dat-hang" => "frontend/quick_order#quick_order", as: :quick_order
    post "dat-hang" => "frontend/quick_order#quick_order"
    get "dat-hang/thanh-cong" => "frontend/shopping_cart#success", as: :checkout_completed
    
    # Search
    get "search" => "frontend/search#search", as: :search

    # Information
    get "ho-tro/cau-hoi-thuong-gap" => "frontend/support#faq", as: :faq
    # get "ho-tro/quy-dinh-chinh-sach" => "frontend/support#terms_and_conditions", as: :terms_and_conditions
    get "ho-tro/:category_id(/:title)" => "frontend/support#policy", as: :policy
    get "site-map" => "frontend/support#site_map", as: :site_map
  end

  Erp::Newsletters::Engine.routes.draw do
		get "newsletter" => "frontend/newsletters#add_email_to_newsletter", as: :newsletters
		post "newsletter" => "frontend/newsletters#add_email_to_newsletter"
  end
  
  namespace :frontend do
		resources :carts
		resources :cart_items do
			collection do
				post "add_to_cart"
				get "remove_cart_item"
			end
    end
  end
end

# *** BACK-END  ***
Erp::Articles::Engine.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    namespace :backend, module: "backend", path: "backend/articles" do
      resources :articles do
        collection do
          post 'list'
          post 'dataselect'
          delete 'delete_all'
          put 'archive_all'
          put 'unarchive_all'
          put 'archive'
          put 'unarchive'
          put 'move_up'
          put 'move_down'
        end
      end
      resources :categories do
        collection do
          post 'list'
          post 'dataselect'
          delete 'delete_all'
          put 'archive_all'
          put 'unarchive_all'
          put 'archive'
          put 'unarchive'
          put 'move_up'
          put 'move_down'
        end
      end
    end
  end
end

Erp::Banners::Engine.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
		namespace :backend, module: "backend", path: "backend/banners" do
      resources :banners do
        collection do
          post 'list'
          post 'dataselect'
          delete 'delete_all'
          put 'archive_all'
          put 'unarchive_all'
          put 'archive'
          put 'unarchive'
          put 'move_up'
          put 'move_down'
        end
      end
      resources :categories do
        collection do
          post 'list'
          post 'dataselect'
          delete 'delete_all'
          put 'archive_all'
          put 'unarchive_all'
          put 'archive'
          put 'unarchive'
        end
      end
    end
  end
end

Erp::Products::Engine.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    namespace :backend, module: "backend", path: "backend/products" do
      resources :products do
        collection do
          post 'list'
          post 'dataselect'
          delete 'delete_all'
          put 'archive'
          put 'unarchive'
          put 'archive_all'
          put 'unarchive_all'
          put 'check_is_bestseller'
          put 'uncheck_is_bestseller'
          put 'check_is_bestseller_all'
          put 'uncheck_is_bestseller_all'
          put 'check_is_call'
          put 'uncheck_is_call'
          put 'check_is_call_all'
          put 'uncheck_is_call_all'
          put 'check_is_new'
          put 'uncheck_is_new'
          put 'check_is_new_all'
          put 'uncheck_is_new_all'
          put 'check_is_published'
          put 'uncheck_is_published'
          put 'check_is_published_all'
          put 'uncheck_is_published_all'
          put 'check_is_call'
          put 'uncheck_is_call'
          put 'check_is_call_all'
          put 'uncheck_is_call_all'
        end
      end
      resources :categories do
        collection do
          post 'list'
          post 'dataselect'
          delete 'delete_all'
          put 'archive_all'
          put 'unarchive_all'
          put 'archive'
          put 'unarchive'
          put 'move_up'
          put 'move_down'
        end
      end
      resources :brands do
        collection do
          post 'list'
          post 'dataselect'
          delete 'delete_all'
          put 'archive_all'
          put 'unarchive_all'
          put 'archive'
          put 'unarchive'
        end
      end
      resources :units do
        collection do
          post 'dataselect'
          post 'list'
          delete 'delete_all'
          put 'archive_all'
          put 'unarchive_all'
          put 'archive'
          put 'unarchive'
        end
      end
    end
  end
end

Erp::Menus::Engine.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
		namespace :backend, module: "backend", path: "backend/menus" do
			resources :menus do
				collection do
					post 'list'
					post 'dataselect'
					delete 'delete_all'
					put 'archive'
					put 'unarchive'
					put 'archive_all'
					put 'unarchive_all'
					put 'move_up'
          put 'move_down'
				end
			end
			resources :related_menus do
				collection do
          get 'related_menu_line_form'
				end
			end
		end
	end
end