class AddArchivedToErpTestimonialsTestimonials < ActiveRecord::Migration[5.0]
  def change
    add_column :erp_testimonials_testimonials, :archived, :boolean, default: false
  end
end
