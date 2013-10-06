class ScoreURL
  include Sidekiq::Worker
  def self.perform(url)
    SharedCountScorer.score(url)
    BitlyScorer.score(url)
  end
end