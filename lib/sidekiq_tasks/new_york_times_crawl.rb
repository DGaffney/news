class NewYorkTimesCrawl
  include Sidekiq::Worker
  
  def perform
    NewYorkTimes.crawl
  end
end