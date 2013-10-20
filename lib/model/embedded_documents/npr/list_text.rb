class NPRListText
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :tag, String
  key :paragraphs, Array

  def self.new_from_raw(list_text)
    obj = self.new
    obj.npr_id = list_text.id
    obj.tag = list_text.tag
    obj.paragraphs = list_text.paragraphs.collect(&:to_s)
    obj
  end
end