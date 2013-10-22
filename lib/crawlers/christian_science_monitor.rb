require 'feedzirra'
class ChristianScienceMonitor < Crawler
  
  def self.crawl
    feed = Feedzirra::Feed.fetch_and_parse(Setting.christian_science_monitor_feed_url)
    feed.entries.each do |article|
      next if !Article.first(:url => article.url).nil?
      ScoreURL.perform_async(article.url)
      ProcessArticle.perform_async(article, "christian_science_monitor")
    end
  end
end