module Erp::Menus
  class MenusProductsCategory < ApplicationRecord
    belongs_to :menu, class_name: "Erp::Menus::Menu"
    belongs_to :category, class_name: "Erp::Products::Category"
  end
end