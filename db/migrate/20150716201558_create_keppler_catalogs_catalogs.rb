class CreateKepplerCatalogsCatalogs < ActiveRecord::Migration
  def change
    create_table :keppler_catalogs_catalogs do |t|
      t.string :cover
      t.string :name
      t.text :description
      t.string :section
      t.boolean :public
      t.string :permalink

      t.timestamps null: false
    end
  end
end
