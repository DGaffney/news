class SharedCount < Scorer
  def self.score(url)
    return Cache.get(url, "shared_count")
  end
end