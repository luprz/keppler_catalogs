#Generado por keppler
require 'elasticsearch/model'
module KepplerCatalogs
  class Catalog < ActiveRecord::Base
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    def self.searching(query)
      if query
        self.search(self.query query).records.order(id: :desc)
      else
        self.order(id: :desc)
      end
    end

    def self.query(query)
      { query: { multi_match:  { query: query, fields: [] , operator: :and }  }, sort: { id: "desc" }, size: self.count }
    end

    #armar indexado de elasticserch
    def as_indexed_json(options={})
      {
        id: self.id.to_s,
        cover:  self.cover.to_s,
        name:  self.name.to_s,
        description:  self.description.to_s,
        section:  self.section.to_s,
        public:  self.public.to_s,
        permalink:  self.permalink.to_s,
      }.as_json
    end

  end
  #Catalog.import
end
