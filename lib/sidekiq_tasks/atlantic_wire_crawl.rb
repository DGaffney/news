class AtlanticWireCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    AtlanticWire.crawl
    AtlanticWireCrawl.perform_async
  end
end