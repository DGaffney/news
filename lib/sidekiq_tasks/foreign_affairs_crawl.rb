class ForeignAffairsCrawl
  include Sidekiq::Worker
  
  def perform
    ForeignAffairs.crawl
    ForeignAffairsCrawl.perform_async
  end
end