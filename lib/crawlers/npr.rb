require 'npr'
class NPRNews < Crawler
  
  def self.crawl(days_ago=30)
    limit = Setting.npr_paginate_value
    NPR.configure do |config|
      config.apiKey         = Setting.npr_api_key
      config.sort           = "date descending"
      config.requiredAssets = "text"
    end
    offset = 0
    articles = NPR::Story.where(date: [days_ago.days.ago..Time.now]).order("date ascending").limit(limit).offset(offset).to_a
    while !articles.empty?
      articles.each do |article|
        ScoreURL.perform_async(article.links.first.to_s)
        ProcessArticle.perform_async(article, "npr")
      end
      offset += limit
      articles = NPR::Story.where(date: [days_ago.days.ago..Time.now]).order("date ascending").limit(limit).offset(offset).to_a
    end
  end
end