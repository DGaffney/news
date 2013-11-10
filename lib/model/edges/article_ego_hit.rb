class ArticleEgoHit
  include MongoMapper::Document
  key :article_ids
  key :ego_id
end