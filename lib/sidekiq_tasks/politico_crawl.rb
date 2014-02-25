class PoliticoCrawl
  include Sidekiq::Worker
   sidekiq_options :queue => :news_source  
  def perform
    Politico.crawl
    PoliticoCrawl.perform_async
  end
end