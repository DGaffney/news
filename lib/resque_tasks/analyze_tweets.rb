class AnalyzeTweets
  include Sidekiq::Worker
  def perform(credentials)
    binding.pry
  end
end