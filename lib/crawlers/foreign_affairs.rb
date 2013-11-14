require 'feedzirra'
class ForeignAffairs < Crawler

  def self.crawl
    feed = Feedzirra::Feed.fetch_and_parse(Setting.foreign_affairs_feed_url)
    feed.entries.each do |article|
      next if !Article.first(:url => article.url).nil?
      ProcessArticle.perform_async(article, "foreign_affairs")
    end
  end
end