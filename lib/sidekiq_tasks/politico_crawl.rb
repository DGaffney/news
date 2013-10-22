class PoliticoCrawl
  include Sidekiq::Worker
  
  def perform
    Politico.crawl
    PoliticoCrawl.perform_async
  end
end