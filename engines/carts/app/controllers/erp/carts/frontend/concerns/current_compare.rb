module Erp
  module Carts
    module Frontend
      module Concerns
        module CurrentCompare
          extend ActiveSupport::Concern
          
          private
            def set_compare
              @compare = Erp::Carts::Compare.find(session[:compare_id])
            rescue ActiveRecord::RecordNotFound
              @compare = Erp::Carts::Compare.create
              session[:compare_id] = @compare.id
            end
        end
      end
    end
  end
end