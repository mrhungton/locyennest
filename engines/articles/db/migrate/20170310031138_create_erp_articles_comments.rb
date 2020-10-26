class CreateErpArticlesComments < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_articles_comments do |t|
      t.text :message
      t.integer :parent_id
      t.boolean :archived, default: false
      t.references :article, index: true, references: :erp_articles_articles
      t.references :user, index: true, references: :erp_users

      t.timestamps
    end
  end
end
