class ScoreURL
  def work(url)
    SharedCount.score(url)
    Bitly.score(url)
  end
end