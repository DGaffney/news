class NPRCrawl
  include Sidekiq::Worker
  
  def perform
    NPRNews.crawl
    NPRCrawl.perform_async
  end
end