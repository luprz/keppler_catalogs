class CreateKepplerCatalogsAttachments < ActiveRecord::Migration
  def change
    create_table :keppler_catalogs_attachments do |t|
      t.string :name
      t.string :upload
      t.text :description
      t.string :image
      t.text :url
      t.text :target
      t.boolean :public
      t.string :permalink
      t.belongs_to :catalog
      t.belongs_to :category

      t.timestamps null: false
    end
  end
end
