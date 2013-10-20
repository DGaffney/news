class NPRBook
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :title, String
  key :link, String
  def self.new_from_raw(book)
    obj = self.new
    obj.npr_id = book.id
    obj.title = book.title
    obj.link = book.link.to_s
    obj
  end
end