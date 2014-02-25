class SalonCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    Salon.crawl
    SalonCrawl.perform_async
  end
end