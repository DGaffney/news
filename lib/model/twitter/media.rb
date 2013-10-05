require_relative 'size'

class Provider::Twitter::Media
  include MongoMapper::EmbeddedDocument
  key :display_url, String
  key :media_url, String
  key :twitter_id, Integer
  key :twitter_id_str, String
  key :media_url_https, String
  key :expanded_url, String
  key :url, String
  key :type, String
  key :indices, Array
  many :sizes, :through => Provider::Twitter::Size, :class_name => "Provider::Twitter::Size"
  belongs_to :tweet
  
  def self.example
    {"display_url"=>"pic.twitter.com/I8kPMVvy", "media_url"=>"http://pbs.twimg.com/media/A9TiOUSCYAArxdM.jpg", "sizes"=>{"thumb"=>{"resize"=>"crop", "h"=>150, "w"=>150}, "large"=>{"resize"=>"fit", "h"=>230, "w"=>632}, "small"=>{"resize"=>"fit", "h"=>124, "w"=>340}, "medium"=>{"resize"=>"fit", "h"=>218, "w"=>600}}, "id_str"=>"276094212766851072", "media_url_https"=>"https://pbs.twimg.com/media/A9TiOUSCYAArxdM.jpg", "expanded_url"=>"http://twitter.com/insomniacevents/status/276094212758462465/photo/1", "url"=>"http://t.co/I8kPMVvy", "type"=>"photo", "id"=>276094212766851072, "indices"=>[118, 138]}
  end

  def self.new_from_raw(media)
    return if media.nil?
    obj = self.new
    obj.display_url     = media["display_url"]
    obj.media_url       = media["media_url"]
    obj.twitter_id      = media["id"]
    obj.twitter_id_str  = media["id_str"]
    obj.media_url_https = media["media_url_https"]
    obj.expanded_url    = media["expanded_url"]
    obj.url             = media["url"]
    obj.type            = media["type"]
    obj.indices         = media["indices"]
    media["sizes"].each_pair do |size_type, size_data|
      size = Provider::Twitter::Size.new_from_raw(size_type, size_data)
      obj.sizes << size
    end
    obj
  end
end