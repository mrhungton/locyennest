Erp::Products::Product.class_eval do
  def get_long_name
    return self.name
  end
  
  def get_short_name
    return self.short_name
  end
end