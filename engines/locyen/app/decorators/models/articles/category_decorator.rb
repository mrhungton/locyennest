Erp::Articles::Category.class_eval do
  # get alias
  def self.get_alias_options()
    [
      {text: I18n.t('articles.alias.blog'),value: self::ALIAS_BLOG},
      {text: I18n.t('articles.alias.about_us'),value: self::ALIAS_ABOUT_US},
      {text: I18n.t('articles.alias.service'),value: self::ALIAS_SERVICE},
      {text: I18n.t('articles.alias.home_about'),value: self::ALIAS_HOME_ABOUT},
      {text: I18n.t('articles.alias.footer_about'),value: self::ALIAS_FOOTER_ABOUT}
    ]
  end

  def self.get_categories_by_alias_about_us
    query = self.get_active
    query = query.where(alias: Erp::Articles::Category::ALIAS_ABOUT_US)
  end

  def get_articles
    self.articles.get_active.order('created_at asc')
  end
end