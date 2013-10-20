class NPRPromoArt
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :book_edition_id, Integer
  key :type, String
  key :width, Integer
  key :src, String
  key :has_border, Boolean
  key :link, String
  
  def self.new_from_raw(promo_art)
    obj = self.new
    obj.npr_id = promo_art.id
    obj.book_edition_id = promo_art.bookEditionId
    obj.type = promo_art.type
    obj.width = promo_art.width
    obj.src = promo_art.src
    obj.has_border = promo_art.hasBorder
    obj.link = promo_art.link.to_s
    obj
  end
end