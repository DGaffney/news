class NPRImageEnlargement
  include MongoMapper::EmbeddedDocument
  key :src, String
  key :caption, String
  def self.new_from_raw(enlargement)
    obj = self.new
    obj.src = enlargement.src
    obj.caption = enlargement.caption
    obj
  end
end