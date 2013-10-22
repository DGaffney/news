require 'feedzirra'
class AtlanticWire < Crawler
  
  def self.crawl
    feed = Feedzirra::Feed.fetch_and_parse(Setting.atlantic_wire_feed_url)
    feed.entries.each do |article|
      url = URI(URI.decode("http%3A%2F%2Fwww.theatlanticwire.com"+article.summary.split("www.theatlanticwire.com")[1].split("\"").first.split("&t=").first)).to_s rescue nil
      next if !Article.first(:url => url).nil?
      ScoreURL.perform_async(url)
      ProcessArticle.perform_async(article, "atlantic_wire")
    end
  end
end