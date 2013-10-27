class HuffingtonPostArticle
  include MongoMapper::EmbeddedDocument
  key :content, String
  key :entry_id, String
  key :published, Time
  key :updated, Time
  key :url, String
  
  def self.new_from_raw(article)
    obj = self.new
    obj.content = article.content
    obj.entry_id = article.entry_id
    obj.published = Time.parse(article.published)
    obj.updated = Time.parse(article.updated)
    obj.url = article.url
    obj
  end
end