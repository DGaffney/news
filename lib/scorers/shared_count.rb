class SharedCountScorer < Scorer
  def self.score(url)
    Cache.get(url, "shared_count")
  end
end