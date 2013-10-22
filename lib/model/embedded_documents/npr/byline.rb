class NPRByline
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :links, Array
  key :name, String
  def self.new_from_raw(byline)
    obj = self.new
    obj.npr_id = byline.id
    obj.links = byline.links
    obj.name = byline.name
    obj
  end
end