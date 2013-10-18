class TwitterCrawlTweets
  include Sidekiq::Worker
  def perform(credentials)
    importer = Importer::Twitter.new(credentials)
    importer.tweets
  end
end