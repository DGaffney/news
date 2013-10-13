class GuardianCrawl
  include Sidekiq::Worker
  
  def perform
    Guardian.crawl
  end
end