class Cache
  include MongoMapper::Document
  key :url, String
  key :content, String
  
  def self.get(url)
    if cached = Cache.first(:url => url)
      return cached.content
    else
      cached = Cache.new(:url => url)
      cached.content = RestClient.get(url)
      cached.save!
      return cached.content
    end
  end
end