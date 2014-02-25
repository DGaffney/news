class NewYorkerCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    NewYorker.crawl
    NewYorkerCrawl.perform_async
  end
end