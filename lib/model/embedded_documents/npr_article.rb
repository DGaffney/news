require_relative 'npr/audio'
require_relative 'npr/book_edition'
require_relative 'npr/byline'
require_relative 'npr/external_asset'
require_relative 'npr/image'
require_relative 'npr/list_text'
require_relative 'npr/member'
require_relative 'npr/organization'
require_relative 'npr/parent'
require_relative 'npr/promo_art'
require_relative 'npr/pull_quote'
require_relative 'npr/related_link'
require_relative 'npr/show'
require_relative 'npr/transcript'
class NPRArticle
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :container
  key :full_text, String
  key :keywords, String
  key :last_modified_date, Time
  key :links, Array
  key :mini_teaser, String
  key :partner_id
  key :priority_keywords, String
  key :pub_date, Time
  key :short_title, String
  key :slug, String
  key :story_date, Time
  key :subtitle, String
  key :teaser, String
  key :text, String
  key :text_with_html, String
  key :thumbnail
  key :title
  many :audio, :through => NPRAudio, :class_name => "NPRAudio"
  many :book_editions, :through => NPRBookEdition, :class_name => "NPRBookEdition"
  many :bylines, :through => NPRByline, :class_name => "NPRByline"
  many :external_assets, :through => NPRExternalAsset, :class_name => "NPRExternalAsset"
  many :images, :through => NPRImage, :class_name => "NPRImage"
  many :list_texts, :through => NPRListText, :class_name => "NPRListText"
  many :members, :through => NPRMember, :class_name => "NPRMember"
  many :organizations, :through => NPROrganization, :class_name => "NPROrganization"
  many :parents, :through => NPRParent, :class_name => "NPRParent"
  many :promo_arts, :through => NPRPromoArt, :class_name => "NPRPromoArt"
  many :pull_quotes, :through => NPRPullQuote, :class_name => "NPRPullQuote"
  many :related_links, :through => NPRRelatedLink, :class_name => "NPRRelatedLink"
  many :shows, :through => NPRShow, :class_name => "NPRShow"
  one :transcript, :through => NPRTranscript, :class_name => "NPRTranscript"
  def self.new_from_raw(article)
    obj = self.new
    obj.npr_id = article.id
    obj.container = article.container
    obj.full_text = article.fullText
    obj.keywords = article.keywords
    obj.last_modified_date = article.lastModifiedDate
    obj.links = article.links.collect(&:to_s)
    obj.mini_teaser = article.miniTeaser
    obj.partner_id = article.partnerId
    obj.priority_keywords = article.priorityKeywords
    obj.pub_date = article.pubDate
    obj.short_title = article.shortTitle
    obj.slug = article.slug
    obj.story_date = article.storyDate
    obj.subtitle = article.subtitle
    obj.teaser = article.teaser
    obj.text = article.text
    obj.text_with_html = article.textWithHtml
    obj.thumbnail = article.thumbnail
    obj.title = article.title
    obj.audio = article.audio.collect{|audio| NPRAudio.new_from_raw(audio)}
    obj.book_editions = article.book_editions.collect{|book_edition| NPRBookEdition.new_from_raw(book_edition)}
    obj.bylines = article.bylines.collect{|byline| NPRByline.new_from_raw(byline)}
    obj.external_assets = article.external_assets.collect{|external_asset| NPRExternalAsset.new_from_raw(external_asset)}
    obj.images = article.images.collect{|image| NPRImage.new_from_raw(image)}
    obj.list_texts = article.list_texts.collect{|list_text| NPRListText.new_from_raw(list_text)}
    obj.members = article.members.collect{|member| NPRMember.new_from_raw(member)}
    obj.organizations = article.organizations.collect{|organization| NPROrganization.new_from_raw(organization)}
    obj.parents = article.parents.collect{|parent| NPRParent.new_from_raw(parent)}
    obj.promo_arts = article.promo_arts.collect{|promo_art| NPRPromoArt.new_from_raw(promo_art)}
    obj.pull_quotes = article.pull_quotes.collect{|pull_quote| NPRPullQuote.new_from_raw(pull_quote)}
    obj.related_links = article.related_links.collect{|related_link| NPRRelatedLink.new_from_raw(related_link)}
    obj.shows = article.shows.collect{|show| NPRShow.new_from_raw(show)}
    obj
  end
  
  def primary_image
    self.images.select{|image| image.primary}.first
  end
end