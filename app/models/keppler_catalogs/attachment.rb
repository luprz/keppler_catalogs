#Generado por keppler
require 'elasticsearch/model'
module KepplerCatalogs
  class Attachment < ActiveRecord::Base
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    belongs_to :catalog
    belongs_to :category
    before_save :create_permalink
    after_update :remove_image
    before_save :url_iframe_service
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
      { query: { multi_match:  { query: query, fields: [:name, :public, :category] , operator: :and }  }, sort: { id: "desc" }, size: self.count }
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
        category: self.category.name,
        public:  self.public ? "Publicado" : "--Publicado",
        permalink:  self.permalink.to_s,
      }.as_json
    end

    def create_permalink
      self.permalink = self.name.downcase.parameterize
    end

    def remove_image
      if !self.image_url.nil? and self.upload != "1"
        image = File.dirname(Rails.root.join("public"+self.image_url))
        FileUtils.rm_rf(image)
      end
    end

    def url_iframe_service
      if !self.url.blank?
        video = self.detected_video_service
        begin
          case video.keys.first
            when "youtube"
              self.url="https://www.youtube.com/embed/"+video.values.first
            when "vimeo"
              self.url="https://player.vimeo.com/video/"+video.values.first
            when "soundcloud"
              detected_soundcloud_sets              
            when "imagen"
            else
              self.url=""
            end
        rescue
          self.url=""
        end
      end
    end

    def detected_soundcloud_sets
      client = Soundcloud.new(:client_id => 'YOUR_CLIENT_ID')
      begin
        track = client.get('/resolve', :url => self.url)
        if self.url.split(/\W+/).include?("sets")
          self.url="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/#{track.id}&amp;color=ff5500&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false"
        else
          self.url="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/#{track.id}&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true"
        end 
      rescue Soundcloud::ResponseError => e
        
      end
    end

    def detected_video_service
      ["youtube", "soundcloud", "vimeo"].each do |service|    
        if service == "vimeo"
          return { service=>self.url.split("/").last }
        else         
          return { service=>self.url.split((/([\w-]{11})/)).last } if self.url.split(/\W+/).include?(service)
        end
      end
      if self.upload == "2"
        {"imagen"=>""}
      end
    end

  end
  #Attachment.import
end
