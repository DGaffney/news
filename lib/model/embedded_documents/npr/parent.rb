#<NPR::Entity::Parent:0x007fc534fc17b8 @id=201492995, @type="collection", @title="News Updates", @links=[http://www.npr.org/series/201492995/news-updates?ft=3&f=, http://api.npr.org/query?id=201492995&apiKey=MDEyNDI3MzE2MDEzODIxNTA0NDM5NjAyZA001]>
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
    obj.links = parent.links.collect(&:to_s)
    obj
  end
end