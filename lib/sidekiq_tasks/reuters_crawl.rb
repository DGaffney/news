class ReutersCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    Reuters.crawl
    ReutersCrawl.perform_async
  end
end