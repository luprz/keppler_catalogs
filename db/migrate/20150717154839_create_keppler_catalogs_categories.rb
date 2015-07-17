class CreateKepplerCatalogsCategories < ActiveRecord::Migration
  def change
    create_table :keppler_catalogs_categories do |t|
      t.string :name
      t.string :permalink

      t.timestamps null: false
    end
  end
end
