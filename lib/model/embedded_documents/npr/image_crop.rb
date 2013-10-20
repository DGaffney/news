class NPRImageCrop
  include MongoMapper::EmbeddedDocument
  key :type, String
  key :src, String
  key :width, Integer
  key :height, Integer
  def self.new_from_raw(crop)
    obj = self.new
    obj.type = crop.type
    obj.src = crop.src
    obj.width = crop.width
    obj.height = crop.height
    obj
  end
end