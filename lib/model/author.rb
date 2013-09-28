class Author
  include MongoMapper::Document
  key :first_name, String
  key :last_name, String
  key :full_name, String
  key :article_ids, Array
  many :articles, :in => :article_ids
end