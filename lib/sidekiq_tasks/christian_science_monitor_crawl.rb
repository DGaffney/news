class ChristianScienceMonitorCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    ChristianScienceMonitor.crawl
    ChristianScienceMonitorCrawl.perform_async
  end
end