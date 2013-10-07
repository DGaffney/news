class Topic
  include MongoMapper::Document
  key :term, String
  key :related, Array
  key :article_ids, Array
  many :articles, :in => :article_ids
end