class SalonCrawl
  include Sidekiq::Worker
  
  def perform
    Salon.crawl
    SalonCrawl.perform_async
  end
end