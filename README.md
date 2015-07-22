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

La siguiente linea habilitará las rutas del engine, debe ser colocada en el archivo `routes.rb`

```ruby
mount KepplerCatalogs::Engine, :at => '/', as: 'catalogs'
```

Para agregar `config/initializers/keppler_catalogs.rb` y asi estabelecer los datos de configuración debe ejecutar

```ruby
rake catalogs:copy_initializer
```

añadir la siguiente linea a su manifesto javascript admin/application.coffee

```
#= require keppler_catalogs/application
#= require ckeditor/init
```

Luego importar migraciones y crear las tablas de contactos desde la consola

```
rake keppler_catalogs:install:migrations 
```
```
rake db:migrate

```
Asignale permisos al modulo en el archivo app/models/ability.rb.

```ruby
  can :manage, KepplerCatalogs::Catalog
  can :manage, KepplerCatalogs::Category
  can :manage, KepplerCatalogs::Attachment
```

Ubicarse en la ruta del proyecto desde la terminal y ejecutar

```ruby
Bundle install
```

## Configuración

Para agregar `config/initializers/catalogs.rb` y asi estabelecer los datos de configuración debe ejecutar

```ruby
rake catalogs:copy_initializer
```


## Configuración de CKeditor

Para configurar el ckeditor con los elementos necesarios para el catalogo crear el archivo `assets/javascripts/ckeditor/config.js` y luego poner lo siguiente:

```javascript
CKEDITOR.editorConfig = function (config) {
   config.toolbar_catalog = [
    ["Styles","Format","Font","FontSize","TextColor","BGColor","Bold",  "Italic",  "Underline",  "Strike",  "-",  "Subscript",  "Superscript", "RemoveFormat", "Preview", "Undo", "Redo", "SelectAll", "NumberedList", "BulletedList", "Link", "Unlink", "Anchor","Outdent","Indent","Blockquote","CreateDiv","JustifyLeft","JustifyCenter","JustifyRight","JustifyBlock","BidiLtr","BidiRtl", "Maximize"]
  ];
  config.toolbar = "mini";  
}
```

## Vistas

Para copiar las vistas en `app/views/keppler_catalogs` y asi personalizarlas para adaptarlas a sus necesidades debe ejecutar

```ruby
rake catalogs:copy_views
```

