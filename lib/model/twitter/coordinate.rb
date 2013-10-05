class Provider::Twitter::Coordinate
  include MongoMapper::EmbeddedDocument
  key :type, String
  #coordinate coordinates are lon lat - geo coordinates are lat lon.
  key :coordinates, Array
  belongs_to :tweet
  
  def self.example
    {"type"=>"Point", "coordinates"=>[4.8930892, 52.37051453]}
  end
  
  def self.new_from_raw(coordinate)
    return if coordinate.nil?
    obj = self.new
    obj.type = coordinate["type"]
    obj.coordinates = coordinate["coordinates"]
    obj
  end
end