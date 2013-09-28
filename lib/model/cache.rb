class Cache
  extend ScorerRequests
  extend CrawlerRequests
  include MongoMapper::Document
  key :url, String
  key :content, String
  key :resource, String
  def self.get(url, resource)
    if cached = Cache.first(:url => url, :resource => resource)
      return cached.content
    else
      cached = Cache.new(:url => url, :resource => resource)
      cached.content = self.send("request_#{resource}", url)
      cached.save!
      return cached.content
    end
  end
end