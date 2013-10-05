class Provider::Twitter::PlaceAttribute
  include MongoMapper::EmbeddedDocument
  key :name, String
  key :value, String
  belongs_to :place

  def self.example
    {"street_address"=>"5403 Stevens Creek Blvd"}
  end
  
  def self.new_from_raw(key,value)
    obj = self.new
    obj.name = key
    obj.value = value
    obj
  end
end