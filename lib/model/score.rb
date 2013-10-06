class Score
  include MongoMapper::Document
  key :provenance, String
  key :url, String
  key :article_id, ObjectId
  key :value, Float
  key :ego_id, ObjectId
  timestamps!
end