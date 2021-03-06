#Generado por keppler
require 'elasticsearch/model'
module KepplerCatalogs
  class Attachment < ActiveRecord::Base
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    belongs_to :catalog
    belongs_to :category
    before_save :create_permalink
    before_save :url_iframe_service    
    before_update :update_uploads
    after_update :remove_image_public
    mount_uploader :image, CoverUploader
    validates_presence_of :category_id, :name, :upload

    
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
      { query: { multi_match:  { query: query, fields: [:name, :description, :category, :public] , operator: :and }  }, sort: { id: "desc" }, size: self.count }
    end

    #armar indexado de elasticserch
    def as_indexed_json(options={})
      {
        id: self.id.to_s,
        name:  self.name,
        description: ActionView::Base.full_sanitizer.sanitize(self.description, tags: []),
        category: self.category.name,
        public:  self.public ? "publicado" : "no--publicado"
      }.as_json
    end

    def create_permalink
      self.permalink = self.name.downcase.parameterize
    end

    def remove_image_public
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
      client = Soundcloud.new(:client_id => '83248842d66fa9b18bf565a65ad8a40e')
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

    def update_uploads
      if self.upload == "1"
        self.url = ""
      else
        self.remove_image!
      end   
    end

  end
  #Attachment.import
end
