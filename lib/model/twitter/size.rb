class Provider::Twitter::Size
  include MongoMapper::EmbeddedDocument
  key :size, String
  key :resize, String
  key :h, Integer
  key :w, Integer
  belongs_to :media
  
  def self.example
    {"thumb"=>{"resize"=>"crop", "h"=>150, "w"=>150}}
  end

  def self.new_from_raw(size_type, size_data)
    return if size_data.nil?
    obj = self.new
    obj.size   = size_type
    obj.resize = size_data["resize"]
    obj.h      = size_data["h"]
    obj.w      = size_data["w"]
    obj
  end
end
