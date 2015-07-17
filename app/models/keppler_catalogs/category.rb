#Generado por keppler
require 'elasticsearch/model'
module KepplerCatalogs
  class Category < ActiveRecord::Base
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    before_save :create_permalink

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
        name:  self.name.to_s,
        permalink:  self.permalink.to_s,
      }.as_json
    end

    private

    def create_permalink
      self.permalink = self.name.downcase.parameterize
    end

  end
  #Category.import
end