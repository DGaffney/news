require 'bitly'
class BitlyScorer < Scorer
  def self.score(url)
    return Cache.get(url, "bitly")
  end
end