#Generado por keppler
require 'elasticsearch/model'
module KepplerCatalogs
  class Attachment < ActiveRecord::Base
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    belongs_to :catalog
    mount_uploader :image, CoverUploader
    
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
      { query: { multi_match:  { query: query, fields: [:name, :public] , operator: :and }  }, sort: { id: "desc" }, size: self.count }
    end

    

    #armar indexado de elasticserch
    def as_indexed_json(options={})
      {
        id: self.id.to_s,
        name:  self.name.to_s,
        upload:  self.upload.to_s,
        description:  self.description.to_s,
        image:  self.image.to_s,
        url:  self.url.to_s,
        target:  self.target.to_s,
        public:  self.public ? "Publicado" : "--Publicado",
        permalink:  self.permalink.to_s,
      }.as_json
    end

  end
  #Attachment.import
end
