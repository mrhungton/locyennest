Erp::Ability.class_eval do
  def testimonials_ability(user)
    can :view, Erp::Testimonials::Testimonial
    can :create, Erp::Testimonials::Testimonial
    can :edit, Erp::Testimonials::Testimonial
    can :delete, Erp::Testimonials::Testimonial
  end
end
