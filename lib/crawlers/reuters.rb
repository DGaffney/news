require 'feedzirra'
class Reuters < Crawler
  
  def self.crawl
    feed = Feedzirra::Feed.fetch_and_parse(Setting.reuters_feed_url)
    feed.entries.each do |article|
      next if !Article.first(:url => article.entry_id).nil?
      ScoreURL.perform_async(article.entry_id)
      ProcessArticle.perform_async(article, "reuters")
    end
  end
end