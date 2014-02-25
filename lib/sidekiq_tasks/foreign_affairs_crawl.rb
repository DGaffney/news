class ForeignAffairsCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    ForeignAffairs.crawl
    ForeignAffairsCrawl.perform_async
  end
end