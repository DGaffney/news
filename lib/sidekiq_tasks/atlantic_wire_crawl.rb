class AtlanticWireCrawl
  include Sidekiq::Worker
  
  def perform
    AtlanticWire.crawl
    AtlanticWireCrawl.perform_async
  end
end