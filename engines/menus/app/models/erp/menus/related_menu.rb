module Erp::Menus
  class RelatedMenu < ApplicationRecord
    belongs_to :parent, class_name: "Erp::Menus::Menu", foreign_key: "parent_id"
    belongs_to :menu, class_name: "Erp::Menus::Menu", foreign_key: "menu_id"
  end
end