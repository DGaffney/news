class TwitterCrawlTweets
  include Sidekiq::Worker
  def self.perform(credentials)
    importer = Importer::Twitter.new(credentials)
    importer.tweets
  end
end