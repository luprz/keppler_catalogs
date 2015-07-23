#Generado por keppler
require 'elasticsearch/model'
module KepplerCatalogs
  class Catalog < ActiveRecord::Base
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    mount_uploader :cover, CoverUploader
    before_save :create_permalink
    has_many :attachments, :dependent => :destroy
    after_update :remove_image

    after_commit on: [:update] do
      puts __elasticsearch__.index_document
    end
    
    def self.searching(query)
      if query
        self.search(self.query query).records.order(id: :desc)
      else
        self.order(id: :desc)
      end
    end

    def self.query(query)
      { query: { multi_match:  { query: query, fields: [:name, :description, :section, :public] , operator: :and }  }, sort: { id: "desc" }, size: self.count }
    end

    #armar indexado de elasticserch
    def as_indexed_json(options={})
      {
        id: self.id.to_s,
        name:  self.name.to_s,
        description: ActionView::Base.full_sanitizer.sanitize(self.description, tags: []),
        section:  self.section,
        public:  self.public.to_s ? "publicado": "no--publicado"
      }.as_json
    end

    private

    def create_permalink
      self.permalink = self.name.downcase.parameterize
    end

    def remove_image
      image = File.dirname(Rails.root.join("public"+self.image_url))
      FileUtils.rm_rf(image)
    end

  end
  #Catalog.import
end
