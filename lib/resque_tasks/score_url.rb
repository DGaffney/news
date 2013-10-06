class ScoreURL
  include Sidekiq::Worker
  def perform(url)
    SharedCountScorer.store_raw(url)
    BitlyScorer.store_raw(url)
    RankURL.perform_in(15.minutes, url)
    ScoreURL.perform_in(1.day, url)
  end
end