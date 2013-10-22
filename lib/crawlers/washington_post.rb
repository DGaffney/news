require 'feedzirra'
class WashingtonPost < Crawler
  
  def self.crawl
    Setting.washington_post_feed_urls.each do |feed_url|
      feed = Feedzirra::Feed.fetch_and_parse(feed_url)
      feed.entries.each do |article|
        next if !Article.first(:url => article.entry_id).nil?
        ScoreURL.perform_async(article.entry_id)
        ProcessArticle.perform_async(JSON.parse(article.to_json), "washington_post")
      end
    end
  end
end