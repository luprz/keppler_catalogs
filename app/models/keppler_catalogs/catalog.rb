#Generado por keppler
require 'elasticsearch/model'
module KepplerCatalogs
  class Catalog < ActiveRecord::Base
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    mount_uploader :cover, CoverUploader
    before_save :create_permalink
    has_many :attachments, :dependent => :destroy

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
      { query: { multi_match:  { query: query, fields: [:name, :section, :public] , operator: :and }  }, sort: { id: "desc" }, size: self.count }
    end

    #armar indexado de elasticserch
    def as_indexed_json(options={})
      {
        id: self.id.to_s,
        cover:  self.cover.to_s,
        name:  self.name.to_s,
        description:  self.description.to_s,
        section:  self.section.to_s,
        public:  self.public.to_s ? "Publicado": "--Publicado",
        permalink:  self.permalink.to_s,
      }.as_json
    end

    private

    def create_permalink
      self.permalink = self.name.downcase.parameterize
    end

  end
  #Catalog.import
end
