class SlateCrawl
  include Sidekiq::Worker
  
  def perform
    Slate.crawl
    SlateCrawl.perform_async
  end
end