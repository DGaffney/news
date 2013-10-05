class TwitterCrawlTweets
  @queue = :main

  def self.perform(credentials)
    importer = Importer::Twitter.new(credentials)
    importer.tweets
  end
end