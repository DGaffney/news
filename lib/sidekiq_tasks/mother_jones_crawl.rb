class MotherJonesCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    MotherJones.crawl
    MotherJonesCrawl.perform_async
  end
end