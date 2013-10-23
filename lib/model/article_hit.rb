class ArticleHit
  include MongoMapper::Document
  key :ego_id, ObjectId
  key :article_id, ObjectId
  key :hit_count, Integer, :default => 0
  
  def increment
    self.hit_count += 1
    self.save
  end
end