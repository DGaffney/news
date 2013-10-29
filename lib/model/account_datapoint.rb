class AccountDatapoint
  include MongoMapper::Document
  key :account_id, ObjectId
  key :provenance, String
  key :value
end