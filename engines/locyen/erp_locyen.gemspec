$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "erp/locyen/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "erp_locyen"
  s.version     = Erp::Locyen::VERSION
  s.authors     = ["Hung Nguyen"]
  s.email       = ["mrhungton@gmail.com"]
  s.homepage    = "http://locyennest.com"
  s.summary     = "Loc Yen Nest website."
  s.description = "Loc Yen Nest website."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"
  s.add_dependency "erp_core"
  s.add_dependency "deface"
end
