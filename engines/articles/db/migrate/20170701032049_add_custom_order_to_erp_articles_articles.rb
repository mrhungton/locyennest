class AddCustomOrderToErpArticlesArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :erp_articles_articles, :custom_order, :integer
  end
end
