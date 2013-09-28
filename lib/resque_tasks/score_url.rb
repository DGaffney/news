class ScoreURL
  @queue = :main

  def self.perform(url)
    SharedCountScorer.score(url)
    BitlyScorer.score(url)
  end
end