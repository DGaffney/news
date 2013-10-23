class EconomistCrawl
  include Sidekiq::Worker
  
  def perform
    Economist.crawl
    EconomistCrawl.perform_async
  end
end