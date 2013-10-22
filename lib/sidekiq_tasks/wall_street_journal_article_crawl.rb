class WallStreetJournalCrawl
  include Sidekiq::Worker
  
  def perform
    WallStreetJournal.crawl
    WallStreetJournalCrawl.perform_async
  end
end