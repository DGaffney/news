class NPRCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    NPRNews.crawl
    NPRCrawl.perform_async
  end
end