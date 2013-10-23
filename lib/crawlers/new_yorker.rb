require 'feedzirra'
class NewYorker < Crawler
  
  def self.crawl
    feed = Feedzirra::Feed.fetch_and_parse(Setting.new_yorker_feed_url)
    feed.entries.each do |article|
      next if !Article.first(:url => article.url).nil?
      ScoreURL.perform_async(article.url)
      ProcessArticle.perform_async(article, "new_yorker")
    end
  end
end