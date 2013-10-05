class Provider::Twitter::Geo
  include MongoMapper::EmbeddedDocument
  key :type, String
  #coordinate coordinates are lon lat - geo coordinates are lat lon.
  key :coordinates, Array
  belongs_to :tweet
  
  def self.example
    {"type"=>"Point", "coordinates"=>[52.37051453, 4.8930892]}
  end
  
  def self.new_from_raw(geo)
    return if geo.nil?
    obj = self.new
    obj.type = geo["type"]
    obj.coordinates = geo["coordinates"]
    obj
  end
end