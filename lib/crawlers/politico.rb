require 'feedzirra'
class Politico < Crawler
  
  def self.crawl
    feed = Feedzirra::Feed.fetch_and_parse(Setting.politico_feed_url)
    feed.entries.each do |article|
      next if !Article.first(:url => article.url).nil?
      ProcessArticle.perform_async(JSON.parse(article.to_json), "politico")
    end
  end
end