module Erp
  module Menus
    module Backend
      class RelatedMenusController < Erp::Backend::BackendController
        def related_menu_line_form
          @related_menu = RelatedMenu.new
          @related_menu.menu_id = params[:add_value]
          
          render partial: params[:partial], locals: {
            related_menu: @related_menu,
            uid: helpers.unique_id()
          }
        end
      end
    end
  end
end
