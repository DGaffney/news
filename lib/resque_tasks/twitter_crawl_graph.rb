class TwitterCrawlGraph
  @queue = :main

  def self.perform(credentials, direction)
    importer = Importer::Twitter.new(credentials)
    importer.graph(direction)
  end
end