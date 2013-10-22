class HuffingtonPostCrawl
  include Sidekiq::Worker
  
  def perform
    HuffingtonPost.crawl
    HuffingtonPostCrawl.perform_async
  end
end