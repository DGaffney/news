class BBCNewsCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    BBCNews.crawl
    BBCNewsCrawl.perform_async
  end
end