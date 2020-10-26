Erp::Testimonials::Engine.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
		namespace :backend, module: "backend", path: "backend/testimonials" do
      resources :testimonials do
        collection do
          post 'list'
          delete 'delete_all'
        end
      end
    end
  end
end