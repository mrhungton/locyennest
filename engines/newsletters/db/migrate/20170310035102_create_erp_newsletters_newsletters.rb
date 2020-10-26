class CreateErpNewslettersNewsletters < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_newsletters_newsletters do |t|
      t.string :email

      t.timestamps
    end
  end
end
