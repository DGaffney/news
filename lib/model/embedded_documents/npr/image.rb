require_relative 'image_crop'
require_relative 'image_enlargement'
class NPRImage
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :caption, String
  key :copyright, String
  key :has_border, Boolean
  key :link, String
  key :primary, Boolean
  key :producer, String
  key :provider, String
  key :src, String
  key :standard, Boolean
  key :title, String
  key :width, Integer
  many :crops, :through => NPRImageCrop, :class_name => "NPRImageCrop"
  one :enlargement, :through => NPRImageEnlargement, :class_name => "NPRImageEnlargement"
  def self.new_from_raw(image)
    obj = self.new
    obj.npr_id = image.id
    obj.caption = image.caption
    obj.copyright = image.copyright
    obj.has_border = image.hasBorder
    obj.link = image.link.to_s
    obj.primary = image.primary?
    obj.producer = image.producer
    obj.provider = image.provider
    obj.src = image.src
    obj.title = image.title
    obj.width = image.width
    obj.crops = image.crops.collect{|crop| NPRImageCrop.new_from_raw(crop)}
    obj.enlargement = NPRImageEnlargement.new_from_raw(image.enlargement) if image.enlargement
    obj
  end
end