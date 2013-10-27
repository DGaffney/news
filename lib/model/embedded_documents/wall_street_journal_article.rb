class WallStreetJournalArticle
  include MongoMapper::EmbeddedDocument
  key :categories, Array
  key :published, Time
  key :summary, String
  key :url, String
  
  def self.new_from_raw(article)
    obj = self.new
    obj.categories = article.categories
    obj.published = Time.parse(article.published)
    obj.summary = article.summary
    obj.url = article.url
    obj
  end
  
  def junk_categories
    return ["FREEEUROPE", "PAID", "FREE", "FREEASIA", "FREEINDIA"]
  end
end