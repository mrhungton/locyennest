Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Erp::Core::Engine => "/", as: 'erp'

  Dir.glob(Rails.root.join('engines').to_s + "/*") do |d|
    eg = d.split(/[\/\\]/).last
		if eg != "core" and Erp::Core.available?(eg)
			mount "Erp::#{eg.camelize}::Engine".constantize => "/", as: 'erp_' + eg
		end
  end
end
