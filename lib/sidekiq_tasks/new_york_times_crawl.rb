class NewYorkTimesCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    NewYorkTimes.crawl
    NewYorkTimesCrawl.perform_async
  end
end