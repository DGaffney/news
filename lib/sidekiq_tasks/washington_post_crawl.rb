class WashingtonPostCrawl
  include Sidekiq::Worker
  
  def perform
    WashingtonPost.crawl
    WashingtonPostCrawl.perform_async
  end
end