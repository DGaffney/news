class ChristianScienceMonitorArticle
  include MongoMapper::EmbeddedDocument
  key :categories, Array
  key :content, String
  key :entry_id, String
  key :id, String
  key :last_modified, Time
  key :published, Time
  key :summary, String
  key :updated, Time
  key :url, String
  
  def self.new_from_raw(article)
    obj = self.new
    obj.categories = article.categories
    obj.content = article.content
    obj.entry_id = article.entry_id
    obj.id = article.id
    obj.last_modified = article.last_modified
    obj.published = article.published
    obj.summary = article.summary
    obj.updated = article.updated
    obj.url = article.url
    obj
  end
end