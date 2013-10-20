class GuardianCrawl
  include Sidekiq::Worker
  
  def perform
    Guardian.crawl
    GuardianCrawl.perform_async
  end
end