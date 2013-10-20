require_relative 'new_york_times_media.rb'

class NewYorkTimesArticle
  include MongoMapper::EmbeddedDocument
  key :section, String
  key :subsection, String
  key :title, String
  key :abstract, String
  key :url, String
  key :byline, String
  key :thumbnail_standard, String
  key :item_type, String
  key :source, String
  key :updated_date, Time
  key :created_date, Time
  key :published_date, Time
  key :material_type_facet, String
  key :kicker, String
  key :subheadline, String
  key :des_facet, Array
  key :org_facet, Array
  key :per_facet, Array
  key :geo_facet, Array
  key :related_urls, Array
  many :media, :through => NewYorkTimesMedia, :class_name => "NewYorkTimesMedia"
  
  def self.new_from_raw(article)
    obj = self.new
    obj.section = article.section
    obj.subsection = article.subsection
    obj.title = article.title
    obj.abstract = article.abstract
    obj.url = article.url
    obj.byline = article.byline
    obj.thumbnail_standard = article.thumbnail_standard
    obj.item_type = article.item_type
    obj.source = article.source
    obj.updated_date = Time.parse(article.updated_date)
    obj.created_date = Time.parse(article.created_date)
    obj.published_date = Time.parse(article.published_date)
    obj.material_type_facet = article.material_type_facet
    obj.kicker = article.kicker
    obj.subheadline = article.subheadline
    obj.des_facet = [article.des_facet].flatten.compact
    obj.org_facet = [article.org_facet].flatten.compact
    obj.per_facet = [article.per_facet].flatten.compact
    obj.geo_facet = [article.geo_facet].flatten.compact
    obj.related_urls = [article.related_urls].flatten.compact
    if article.multimedia && !article.multimedia.empty?
      article.multimedia.each do |media|
        media_obj = NewYorkTimesMedia.new_from_raw(media)
        obj.media << media_obj
      end
    end
    obj.save
    obj
  end
end