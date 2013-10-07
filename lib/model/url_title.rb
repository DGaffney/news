class URLTitle
  include MongoMapper::Document
  key :title, String
  key :account_id, ObjectId
  key :provenance, String
  key :provenance_id, ObjectId
end
