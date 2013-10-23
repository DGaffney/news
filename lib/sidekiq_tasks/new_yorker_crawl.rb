class NewYorkerCrawl
  include Sidekiq::Worker
  
  def perform
    NewYorker.crawl
    NewYorkerCrawl.perform_async
  end
end