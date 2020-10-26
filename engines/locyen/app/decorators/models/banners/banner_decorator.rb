Erp::Banners::Banner.class_eval do
  def self.get_certificates
    self.get_active.joins(:category).where(erp_banners_categories: {position: Erp::Banners::Category::POSITION_CERTIFICATE})
  end
end