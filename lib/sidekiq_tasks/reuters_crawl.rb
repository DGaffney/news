class ReutersCrawl
  include Sidekiq::Worker
  
  def perform
    Reuters.crawl
    ReutersCrawl.perform_async
  end
end