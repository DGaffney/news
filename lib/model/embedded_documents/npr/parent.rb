class NPRParent
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :type, String
  key :title, String
  key :links, Array
  
  def self.new_from_raw(parent)
    obj = self.new
    obj.npr_id = parent.id
    obj.type = parent.type
    obj.links = parent.links
    obj
  end
end