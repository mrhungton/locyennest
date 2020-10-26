class CreateErpArticlesCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_articles_categories do |t|
      t.string :name
      t.text :description
      t.integer :parent_id
      t.string :alias
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
