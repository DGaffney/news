class GuardianCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    Guardian.crawl
    GuardianCrawl.perform_async
  end
end