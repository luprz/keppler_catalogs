Rails.application.routes.draw do

  mount KepplerCatalogs::Engine => "/keppler_catalogs"
end
