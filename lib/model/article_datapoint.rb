class ArticleDatapoint
  include MongoMapper::Document
  key :article_id, ObjectId
  key :provenance, String
  key :value
end