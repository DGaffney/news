class GuardianArticle
  include MongoMapper::Document
  key :section_id, String
  key :section_name, String
  key :web_publication_date, Time
  key :last_modified, Time
  key :web_title, String
  key :headline, String
  key :publication, String
  key :web_url, String
  key :api_url, String
  key :short_url, String
  key :thumbnail, String
  key :wordcount, Integer
  key :score, Float

  def self.new_from_raw(article)
    obj = self.new
    obj.section_id = article.sectionId
    obj.section_name = article.sectionName
    obj.web_publication_date = Time.parse(article.webPublicationDate)
    obj.last_modified = Time.parse(article.fields.last_modified)
    obj.web_title = article.webTitle
    obj.headline = article.fields.headline
    obj.publication = article.fields.publication
    obj.web_url = article.webUrl
    obj.api_url = article.apiUrl
    obj.short_url = article.fields.shortUrl
    obj.thumbnail = article.fields.thumbnail
    obj.wordcount = article.fields.wordcount.to_i
    obj.score = article.fields.score.to_f
    obj.save!
    obj
  end
end