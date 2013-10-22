require 'feedzirra'
class MotherJones < Crawler
  
  def self.crawl
    feed = Feedzirra::Feed.fetch_and_parse(Setting.mother_jones_feed_url)
    feed.entries.each do |article|
      next if !Article.first(:url => article.url).nil?
      ScoreURL.perform_async(url)
      ProcessArticle.perform_async(JSON.parse(article.to_json), "mother_jones")
    end
  end
end