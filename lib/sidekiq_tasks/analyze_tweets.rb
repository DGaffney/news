class AnalyzeTweets
  include Sidekiq::Worker
  def perform(credentials)
    puts woo
  end
end