class MotherJonesArticle
  include MongoMapper::EmbeddedDocument
  key :categories, Array
  key :entry_id, String
  key :id, String
  key :published, Time
  key :summary, String
  key :url, String
  
  def self.new_from_raw(article)
    obj = self.new
    obj.categories = article.categories
    obj.entry_id = article.entry_id
    obj.published = article.published
    obj.summary = article.summary
    obj.url = article.url
    obj
  end
end