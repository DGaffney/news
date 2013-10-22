class WashingtonPostArticle
  include MongoMapper::EmbeddedDocument
  key :categories, Array
  key :entry_id, String
  key :last_modified, Time
  key :published, Time
  key :summary, String
  key :updated, Time
  key :url, String
  
  def self.new_from_raw(article)
    obj = self.new
    obj.categories = article.categories
    obj.entry_id = article.entry_id
    obj.published = Time.parse(article.published)
    obj.summary = article.summary
    obj.url = article.url
    obj
  end
end