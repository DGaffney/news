class Provider::Twitter::BoundingBox
  include MongoMapper::EmbeddedDocument
  key :type, String, :required => true
  key :coordinates, Array, :required => true
  belongs_to :place
  
  def self.example
    {"type"=>"Polygon", "coordinates"=>[[[4.7289, 52.278227], [5.079207, 52.278227], [5.079207, 52.431229], [4.7289, 52.431229]]]}
  end
  
  def self.new_from_raw(bounding_box)
    return if bounding_box.nil?
    obj = self.new
    obj.type = bounding_box["type"]
    obj.coordinates = bounding_box["coordinates"]
    obj
  end
end