## Keppler Catálogo

Un sistema de manejo y control de catalogos integrado Keppler-Admin. Este módulo puedo almacenar y ordenar imágenes así como tambien servicos multimedia en la nube como Youtube, Vimeo y Soundcloud.

## Características


- Catálogo de imágenes, Audio y Video.
- Configuración para personalización

## Requerimientos

* Ruby >= 2.0.0
* Rails >= 4.0.0
* Keppler-admin >= 1.0.0

## Instalación

Añadir la siguiente linea a su Gemfile

```ruby
gem 'keppler_catalogs', git: "https://github.com/inyxtech/keppler_catalogs.git"
gem 'carrierwave'
gem "ckeditor"
```

Ubicarse en la ruta del proyecto desde la terminal y ejecutar

```ruby
Bundle install
```

Luego importar migraciones y crear las tablas de contactos desde la consola

```
rake keppler_catalogs:install:migrations 
rake db:migrate
```

Debe asignar los permisos de autorización para que pueda tener acceso a los módulos del blog, esto debe hacerlo desde el archivo `model/ability.rb`

```ruby
  can :manage, KepplerCatalogs::Catalog
  can :manage, KepplerCatalogs::Category
  can :manage, KepplerCatalogs::Attachment
```

La siguiente linea habilitará las rutas del engine, debe ser colocada en el archivo `routes.rb`

```ruby
mount KepplerCatalogs::Engine, :at => '/', as: 'catalogs'
```

Para agregar `config/initializers/catalogs.rb` y asi estabelecer los datos de configuración debe ejecutar

```ruby
rake catalogs:copy_initializer
```
En el archivo inicializador `config/initializers/catalogs.rb` encontraras una variable llamada sections en donde podrás agregar las sección de la web en los que se localizarán los catálogos. por ejemplo:

```ruby
KepplerCatalogs.setup do |config|
	config.sections = ["Clientes", "Aliados", "Portafolio"]
end
```

Añadir la siguiente linea a su manifesto stylesheets

```
@import "keppler_catalogs/admin/application";
```

Añadir la siguiente linea a su manifesto javascript `admin/application.coffee`

```
#= require keppler_catalogs/application
```

## Renderizar Imagenes, Video y audio

Este render lee la url del archivo y asigna un tag iframe o img dependiendo del tipo de archivo que consultes.

```ruby
# attachment_object es la variable que contiene el objeto de un archivo
= render "keppler_catalogs/attachments/mediaframe", attachment: <Attachment_object>, style:"<css_config>"
```

## Vistas

Para copiar las vistas en `app/views/keppler_catalogs` y asi personalizarlas para adaptarlas a sus necesidades debe ejecutar

```ruby
rake catalogs:copy_views
```

