class NPRMember
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :title, String
  key :promo_art
  key :author
  key :book_edition
  def self.new_from_raw(member)
    obj = self.new
    obj.npr_id = member.id
    obj.title = member.title
    obj.promo_art = member.promo_art
    obj.author = member.author
    obj.book_edition = member.book_edition
    obj
  end
end