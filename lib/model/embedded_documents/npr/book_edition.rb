require_relative 'book'
class NPRBookEdition
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :format_num, Integer
  key :isbn, String
  key :publisher, String
  key :pub_date, Time
  key :pagination, String
  key :list_price, String
  one :book, :through => NPRBook, :class_name => "NPRBook"
  
  def self.new_from_raw(book_edition)
    obj = self.new
    obj.npr_id = book_edition.id
    obj.format_num = book_edition.format_num
    obj.isbn = book_edition.isbn
    obj.publisher = book_edition.publisher
    obj.pub_date = book_edition.pubDate
    obj.pagination = book_edition.pagination
    obj.list_price = book_edition.listPrice
    obj.book = NPRBook.new_from_raw(book_edition.book)
    obj
  end
end