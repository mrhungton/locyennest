class CreateErpArticlesArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_articles_articles do |t|
      t.string :image
      t.string :name
      t.text :content
      t.string :meta_keywords
      t.string :meta_description
      t.string :tags
      t.boolean :archived, default: false
      t.references :category, index: true, references: :erp_articles_categories
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end