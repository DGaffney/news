class ScoreURL
  include Sidekiq::Worker
  def perform(url)
    SharedCountScorer.score(url)
    BitlyScorer.score(url)
  end
end