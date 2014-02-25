class SlateCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    Slate.crawl
    SlateCrawl.perform_async
  end
end