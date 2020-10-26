Erp::Articles::Article.class_eval do
  # get all home about us
  def self.get_all_home_abouts
    query = self.get_active
    query = query.joins(:category).where('erp_articles_categories.alias = ?', Erp::Articles::Category::ALIAS_HOME_ABOUT)
    query = query.order('erp_articles_articles.custom_order ASC')
  end

  # get all about us
  def self.get_all_about_us
    query = self.get_active
    query = query.joins(:category).where('erp_articles_categories.alias = ?', Erp::Articles::Category::ALIAS_ABOUT_US)
    query = query.order('erp_articles_articles.custom_order ASC')
  end

  # get all footer about us
  def self.get_all_footer_abouts
    query = self.get_active
    query = query.joins(:category).where('erp_articles_categories.alias = ?', Erp::Articles::Category::ALIAS_FOOTER_ABOUT)
    query = query.order('erp_articles_articles.custom_order ASC')
  end
end