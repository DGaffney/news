require 'bitly'
class BitlyScorer < Scorer
  def self.store_raw(url)
    return JSON.parse(Cache.get(url, "bitly"))
  end
  
  def self.percentile(url)
    bitly_score = Cache.first(resource: "bitly", url: url).content["clicks"] rescue 0
    other_bitly_scores = Cache.where(resource: "bitly").limit(1000).order(:_rand).collect{|c| c.content["clicks"] rescue nil}.compact
    bitly_percentile = other_bitly_scores.reverse_percentile(bitly_score)
  end
end