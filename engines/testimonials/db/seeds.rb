puts "Create sample testimonials"
Erp::Testimonials::Testimonial.where(author: "Mr. Brian").destroy_all
testimonial1 = Erp::Testimonials::Testimonial.create(author: "Mr. Brian", content: "Nội dung đang được cập nhật...")
Erp::Testimonials::Testimonial.where(author: "Mr. Alfred").destroy_all
testimonial2 = Erp::Testimonials::Testimonial.create(author: "Mr. Alfred", content: "Nội dung đang được cập nhật...")
Erp::Testimonials::Testimonial.where(author: "Mrs. Pearl").destroy_all
testimonial3 = Erp::Testimonials::Testimonial.create(author: "Mrs. Pearl", content: "Nội dung đang được cập nhật...")