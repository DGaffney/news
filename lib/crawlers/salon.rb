require 'feedzirra'
class Salon < Crawler
  
  def self.crawl
    feed = Feedzirra::Feed.fetch_and_parse(Setting.salon_feed_url)
    feed.entries.each do |article|
      url = Nokogiri::HTML(article.content).search("a").select{|a| a.text == "Continue Reading..."}.first.attributes.href.value rescue nil
      next if !Article.first(:url => url).nil? || url.nil?
      ProcessArticle.perform_async(JSON.parse(article.to_json), "salon")
    end
  end
end

