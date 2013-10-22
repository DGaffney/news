class ChristianScienceMonitorCrawl
  include Sidekiq::Worker
  
  def perform
    ChristianScienceMonitor.crawl
    ChristianScienceMonitorCrawl.perform_async
  end
end