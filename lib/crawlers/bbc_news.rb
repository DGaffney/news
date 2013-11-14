require 'feedzirra'
class BBCNews < Crawler
  
  def self.crawl
    feed = Feedzirra::Feed.fetch_and_parse(Setting.bbc_news_feed_url)
    feed.entries.each do |article|
      next if !Article.first(:url => article.url).nil?
      ProcessArticle.perform_async(article, "bbc_news")
    end
  end
end