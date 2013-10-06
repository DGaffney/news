class Account
  include MongoMapper::Document
  key :term, String
  key :related, Array
  key :provenance, String
end