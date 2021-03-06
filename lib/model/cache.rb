class Cache
  extend ScorerRequests
  extend CrawlerRequests
  extend TwitterRequests

  include MongoMapper::Document

  key :url, String
  key :content
  key :resource, String
  key :opts, Hash
  key :created_at, Time, :default => Time.now
  key :updated_at, Time, :default => Time.now

  def self.get(url, resource, opts={}, last_updated_at = Time.now-1.day)
    cached = Cache.first(:url => url, :resource => resource, :opts => opts)
    if cached && cached.updated_at > last_updated_at
      return cached.content
    else
      cached = Cache.first_or_new(:url => url, :resource => resource, :opts => opts)
      cached.content = self.send("request_#{resource}", url, opts)
      cached.updated_at = Time.now
      cached.created_at ||= Time.now
      cached.save!
      return cached.content
    end
  end
end