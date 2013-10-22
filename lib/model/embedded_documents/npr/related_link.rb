class NPRRelatedLink
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :caption, String
  key :links, Array
  key :type, String
  
  def self.new_from_raw(related_link)
    obj = self.new
    obj.npr_id = related_link.id
    obj.caption = related_link.caption
    obj.links = related_link.links
    obj.type = related_link.type
    obj
  end
end