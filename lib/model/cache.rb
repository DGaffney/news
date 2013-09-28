class Cache
  include MongoMapper::Document
  extend ScorerRequests
  extend CrawlerRequests
  key :url, String
  key :content, String
  
  def self.get(url, resource)
    if cached = Cache.first(:url => url)
      return cached.content
    else
      cached = Cache.new(:url => url)
      cached.content = self.send("request_#{resource}", url)
      cached.save!
      return cached.content
    end
  end
end