class TwitterCrawlGraph
  include Sidekiq::Worker
  def self.perform(credentials, direction)
    importer = Importer::Twitter.new(credentials)
    importer.graph(direction)
  end
end