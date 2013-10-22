require 'feedzirra'
require 'open-uri'
class WallStreetJournal < Crawler
  
  def self.crawl
    Setting.wall_street_journal_feed_urls.each do |feed_url|
      feed = Feedzirra::Feed.fetch_and_parse(feed_url)
      feed.entries.each do |article|
        url = nil
        open(article.url) do |resp|
          url = resp.base_uri.to_s
        end
        next if !Article.first(:url => url).nil?
        ScoreURL.perform_async(url)
        ProcessArticle.perform_async(JSON.parse(article.to_json).merge({actual_url: url}), "wall_street_journal")
      end
    end
  end
end