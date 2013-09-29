class NewYorkTimesMedia
  include MongoMapper::EmbeddedDocument
  key :url, String
  key :format, String
  key :height, Integer
  key :width, Integer
  key :type, String
  key :subtype, String
  key :caption, String
  key :copyright, String
  
  def self.new_from_raw(media)
    obj = self.new
    obj.url = media.url
    obj.format = media.format
    obj.height = media.height
    obj.width = media.width
    obj.type = media.type
    obj.subtype = media.subtype
    obj.caption = media.caption
    obj.copyright = media.copyright
    obj
  end
end
