class AddCustomOrderToErpArticlesCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :erp_articles_categories, :custom_order, :integer
  end
end
