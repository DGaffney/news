class ForeignAffairsArticle
  include MongoMapper::EmbeddedDocument
  key :categories, Array
  key :entry_id, String
  key :summary, String
  key :url, String
  
  def self.new_from_raw(article)
    obj = self.new
    obj.categories = article.categories
    obj.entry_id = article.entry_id
    obj.summary = article.summary
    obj.url = article.url
    obj
  end
end