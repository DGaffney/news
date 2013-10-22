class BBCNewsCrawl
  include Sidekiq::Worker
  
  def perform
    BBCNews.crawl
    BBCNewsCrawl.perform_async
  end
end