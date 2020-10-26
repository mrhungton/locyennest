class AddWorkplaceToErpTestimonialsTestimonials < ActiveRecord::Migration[5.0]
  def change
    add_column :erp_testimonials_testimonials, :workplace, :string
  end
end
