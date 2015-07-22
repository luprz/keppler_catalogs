module KepplerCatalogs
  class Engine < ::Rails::Engine
    isolate_namespace KepplerCatalogs
    config.generators do |g|
	  g.template_engine :haml
	end
	config.to_prepare do
      ApplicationController.helper(ApplicationHelper)
    end
  end
end
