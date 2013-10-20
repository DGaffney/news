class NewYorkTimesCrawl
  include Sidekiq::Worker
  
  def perform
    NewYorkTimes.crawl
    NewYorkTimesCrawl.perform_async
  end
end