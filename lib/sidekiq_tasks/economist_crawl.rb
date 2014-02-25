class EconomistCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    Economist.crawl
    EconomistCrawl.perform_async
  end
end