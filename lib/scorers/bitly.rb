require 'bitly'
class BitlyScorer < Scorer
  def self.score(url)
    return JSON.parse(Cache.get(url, "bitly"))
  end
end