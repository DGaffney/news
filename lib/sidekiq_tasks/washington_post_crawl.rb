class WashingtonPostCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    WashingtonPost.crawl
    WashingtonPostCrawl.perform_async
  end
end