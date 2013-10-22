require 'feedzirra'
class HuffingtonPost < Crawler
  
  def self.crawl
    feed = Feedzirra::Feed.fetch_and_parse(Setting.huffington_post_feed_url)
    feed.entries.each do |article|
      next if !Article.first(:url => article.url).nil?
      ScoreURL.perform_async(article.url)
      ProcessArticle.perform_async(JSON.parse(article.to_json), "huffington_post")
    end
  end
end