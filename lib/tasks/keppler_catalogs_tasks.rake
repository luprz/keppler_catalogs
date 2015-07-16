# desc "Explaining what the task does"
# task :keppler_catalogs do
#   # Task goes here
# end
require File.expand_path('../../keppler_catalogs/tasks/install', __FILE__)

namespace :catalogs do
	desc "Copiar inicializador para la configuración"
	task :copy_initializer do
		KepplerCatalogs::Tasks::Install.copy_initializer_file
	end

  desc "Copiar vistas al proyecto"
  task :copy_views do
    KepplerCatalogs::Tasks::Install.copy_view_files
  end
end