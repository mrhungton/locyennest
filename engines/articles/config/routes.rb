Erp::Articles::Engine.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
		namespace :backend, module: "backend", path: "backend/articles" do
      resources :articles do
        collection do
          post 'list'
          get 'dataselect'
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
          get 'dataselect'
          delete 'delete_all'
          put 'archive_all'
          put 'unarchive_all'
          put 'archive'
          put 'unarchive'
          put 'move_up'
          put 'move_down'
        end
      end
      resources :comments do
        collection do
          post 'list'
          delete 'delete_all'
          put 'archive_all'
          put 'unarchive_all'
          put 'archive'
          put 'unarchive'
          get 'children_comments'
        end
      end
    end
  end
end
