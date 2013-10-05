class Cache
  extend ScorerRequests
  extend CrawlerRequests
  extend TwitterRequests
  include MongoMapper::Document
  key :url, String
  key :content
  key :resource, String
  key :opts, Hash
  def self.get(url, resource, opts={})
    if cached = Cache.first(:url => url, :resource => resource, :opts => opts)
      return cached.content
    else
      cached = Cache.new(:url => url, :resource => resource, :opts => opts)
      cached.content = self.send("request_#{resource}", url, opts)
      cached.save!
      return cached.content
    end
  end
end