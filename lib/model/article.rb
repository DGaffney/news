class Article
  include MongoMapper::Document
  key :title, String
  key :author_id, ObjectId
  key :content, String
  belongs_to :author
  timestamps!
end