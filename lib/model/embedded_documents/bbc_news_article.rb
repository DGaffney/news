class BBCNewsArticle
  include MongoMapper::EmbeddedDocument
  key :entry_id, String
  key :published, Time
  key :summary, String
  key :url, String
  
  def self.new_from_raw(article)
    obj = self.new
    obj.entry_id = article.entry_id
    obj.published = Time.parse(article.published)
    obj.summary = article.summary
    obj.url = article.url
    obj
  end
end