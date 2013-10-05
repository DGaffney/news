require_relative 'place_attribute'
require_relative 'bounding_box'

class Provider::Twitter::Place
  include MongoMapper::EmbeddedDocument
  key :twitter_id, String, :required => true
  key :url, String, :required => true
  key :place_type, String, :required => true
  key :name, String, :required => true
  key :full_name, String, :required => true
  key :country_code, String, :required => true
  key :country, String, :required => true
  one :bounding_box, :through => Provider::Twitter::BoundingBox, :class_name => "Provider::Twitter::BoundingBox"
  many :place_attributes, :through => Provider::Twitter::PlaceAttribute, :class_name => "Provider::Twitter::PlaceAttribute"
  belongs_to :tweet

  def self.example
    {"id"=>"99cdab25eddd6bce", "url"=>"http://api.twitter.com/1/geo/id/99cdab25eddd6bce.json", "place_type"=>"city", "name"=>"Amsterdam", "full_name"=>"Amsterdam, North Holland", "country_code"=>"NL", "country"=>"The Netherlands", "bounding_box"=>{"type"=>"Polygon", "coordinates"=>[[[4.7289, 52.278227], [5.079207, 52.278227], [5.079207, 52.431229], [4.7289, 52.431229]]]}, "attributes"=>{}}
  end
    
  def self.new_from_raw(place)
    return if place.nil?
    obj = self.new
    obj.twitter_id   = place["twitter_id"]
    obj.url          = place["url"]
    obj.place_type   = place["place_type"]
    obj.name         = place["name"]
    obj.full_name    = place["full_name"]
    obj.country_code = place["country_code"]
    obj.country      = place["country"]
    bounding_box = Provider::Twitter::BoundingBox.new_from_raw(place["bounding_box"])
    if bounding_box
      obj.bounding_box = bounding_box
    end
    
    place["attributes"].each_pair do |key, value|
      place = Provider::Twitter::PlaceAttribute.new_from_raw(key, value)
      obj.place_attributes << place
    end
    obj
  end
end