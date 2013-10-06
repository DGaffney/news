class SharedCountScorer < Scorer
  def self.store_raw(url)
    return Cache.get(url, "shared_count")
  end
  
  def self.percentile(url)
    shared_count_data = JSON.Parse(Cache.first(resource: "shared_count", url: url).content)
    keys = shared_count_data.keys
    other_shared_count_scores = Cache.where(resource: "shared_count").limit(1000).order(:_rand).collect{|c| c.content rescue nil}.compact
    percentile_raw = {}
    keys.each do |key|
      other_shared_count_scores.each do |other_shared_count_score|
        if other_shared_count_score[key].class == BSON::OrderedHash
          other_shared_count_score[key].each do |k, v|
            percentile_raw[key+"_"+k.to_s] ||= []
            percentile_raw[key+"_"+k.to_s] << v
          end
        else
          percentile_raw[key] ||= []
          percentile_raw[key] << other_shared_count_score[key]
        end
      end
    end
    percentiles = {}
    shared_count_data.each do |key, value|
      if value.class == BSON::OrderedHash
        value.each do |k,v|
          percentiles[key+"_"+k.to_s] = percentile_raw[key+"_"+k.to_s].reverse_percentile(v) if percentile_raw[key+"_"+k.to_s]
        end
      else
          puts key
          percentiles[key] = percentile_raw[key].reverse_percentile(value) if percentile_raw[key]
      end
    end
    percentiles
  end
end