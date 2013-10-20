require 'feedzirra'
class AtlanticWire < Crawler
  
  def self.crawl
    feed = Feedzirra::Feed.fetch_and_parse("http://feeds.feedburner.com/TheAtlanticWire?format=xml")
    feed.entries.each do |article|
      url = URI(URI.decode("http%3A%2F%2Fwww.theatlanticwire.com"+article.summary.split("www.theatlanticwire.com")[1].split("\"").first.split("&t=").first)).to_s rescue nil
      ScoreURL.perform_async(url)
      ProcessArticle.perform_async(article, "atlantic_wire")
    end
  end
end