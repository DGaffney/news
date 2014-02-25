class WallStreetJournalCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source
  def perform
    WallStreetJournal.crawl
    WallStreetJournalCrawl.perform_async
  end
end