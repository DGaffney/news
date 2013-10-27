class Topic
  include MongoMapper::Document
  key :topic, String
  key :related_term, String
  key :score, Integer
end