class SalonArticle
  include MongoMapper::EmbeddedDocument
  key :categories, Array
  key :content, String
  key :entry_id, String
  key :published, Time
  key :summary, String
  key :url, String
  
  def self.new_from_raw(article)
    obj = self.new
    obj.categories = article.categories
    obj.content = article.content
    obj.entry_id = article.entry_id
    obj.published = Time.parse(article.published)
    obj.summary = article.summary
    obj.url = article.url
    obj
  end
  
  def junk_categories
    return ["All Salon"]
  end
end