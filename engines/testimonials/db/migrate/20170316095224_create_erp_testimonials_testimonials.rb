class CreateErpTestimonialsTestimonials < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_testimonials_testimonials do |t|
      t.string :logo
      t.string :author
      t.text :content

      t.timestamps
    end
  end
end
