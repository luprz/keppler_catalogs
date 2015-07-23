$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "keppler_catalogs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "keppler_catalogs"
  s.version     = KepplerCatalogs::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = "https://github.com/inyxtech/keppler_catalogs.git"
  s.summary     = "Summary of KepplerCatalogs."
  s.description = "Un sistema de manejo y control de catalogos integrado Keppler-Admin. Este módulo puedo almacenar y ordenar imágenes así como tambien servicos multimedia en la nube como Youtube, Vimeo y Soundcloud."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "simple_form"
  s.add_dependency "haml_rails"
  s.add_dependency "carrierwave"
  s.add_dependency "ckeditor"
  s.add_dependency "soundcloud"
  
end
