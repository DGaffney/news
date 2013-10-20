class NPRCrawl
  include Sidekiq::Worker
  
  def perform
    NPRNews.crawl
  end
end