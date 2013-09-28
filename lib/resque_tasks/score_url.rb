class ScoreURL
  def work(url)
    SharedCountScorer.score(url)
    BitlyScorer.score(url)
  end
end