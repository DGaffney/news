class GuardianArticle
  include MongoMapper::EmbeddedDocument
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
    obj.web_title = article.webTitle
    obj.web_url = article.webUrl
    obj.api_url = article.apiUrl
    obj.last_modified = Time.parse(article.fields.lastModified) rescue nil
    obj.headline = article.fields.headline rescue nil
    obj.publication = article.fields.publication rescue nil
    obj.short_url = article.fields.shortUrl rescue nil
    obj.thumbnail = article.fields.thumbnail rescue nil
    obj.wordcount = article.fields.wordcount.to_i rescue nil
    obj.score = article.fields.score.to_f rescue nil
    obj.save
    obj
  end
end