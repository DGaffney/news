class MotherJonesCrawl
  include Sidekiq::Worker
  
  def perform
    MotherJones.crawl
    MotherJonesCrawl.perform_async
  end
end