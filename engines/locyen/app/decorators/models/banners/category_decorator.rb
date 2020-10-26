Erp::Banners::Category.class_eval do
  # get position for banner type
  def self.get_position_options()
    [
      {text: 'home_slideshow',value: self::POSITION_HOME_SLIDESHOW},
      {text: 'home_certification',value: self::POSITION_CERTIFICATE},
    ]
  end    
end