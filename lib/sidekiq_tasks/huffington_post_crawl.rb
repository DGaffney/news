class HuffingtonPostCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    HuffingtonPost.crawl
    HuffingtonPostCrawl.perform_async
  end
end