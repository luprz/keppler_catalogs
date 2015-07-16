module KepplerCatalogs
  class Engine < ::Rails::Engine
    isolate_namespace KepplerCatalogs
    config.generators do |g|
	  g.template_engine :haml
	end
  end
end
