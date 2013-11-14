require 'feedzirra'
class Slate < Crawler
  
  def self.crawl
    feed = Feedzirra::Feed.fetch_and_parse(Setting.slate_feed_url)
    feed.entries.each do |article|
      next if !Article.first(:url => article.url).nil?
      ProcessArticle.perform_async(article, "slate")
    end
  end
end