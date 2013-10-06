class TwitterCrawlGraph
  include Sidekiq::Worker
  def perform(credentials, direction)
    importer = Importer::Twitter.new(credentials)
    importer.graph(direction)
  end
end