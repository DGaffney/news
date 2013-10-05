class SharedCountScorer < Scorer
  def self.score(url)
    return JSON.parse(Cache.get(url, "shared_count"))
  end
end