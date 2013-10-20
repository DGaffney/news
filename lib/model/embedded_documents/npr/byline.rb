class NPRByline
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :links, Array
  key :name, String
  def self.new_from_raw(byline)
    obj = self.new
    obj.npr_id = byline.id
    obj.links = byline.links.collect(&:to_s)
    obj.name = byline.name.to_s
    obj
  end
end