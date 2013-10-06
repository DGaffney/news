class TestCity
  
  def self.topic_frequencies
    facets = Article.all.collect { |article| article.new_york_times.des_facet }
    topics = facets.flatten
    self.word_freq(topics)
  end

  def self.word_freq(topics)
    topics.inject(Hash.new(0)) { |freq, topic| freq[topic] += 1; freq }
  end

  def self.sort(freq)
    freq.sort_by { |k, v| v }.reverse!
  end

  def self.print_simple_topic_frequencies
    freq = self.topic_frequencies
    sorted = self.sort(freq)
    sorted.each_with_index { |arr, i| print "#{i}.  #{arr[0]}:  #{arr[1]}\n" }
  end

  def self.topic_stats
    freq = self.topic_frequencies
    stats = []
    sum = 0

    freq.each_pair do |k, v| 
      stats << { :topic => k, :frequency => v } 
      sum += v
    end

    stats.each { |elem| elem[:relative_frequency] = elem[:frequency] / sum.to_f }

    stats
  end

  def self.print_topic_stats
    stats = self.topic_stats
    sorted = stats.sort_by { |elem| elem[:frequency] }
    sorted.reverse!

    sorted.each_with_index { |elem, i| print "#{i}.  #{elem[:topic]}\n----frequency: #{elem[:frequency]}\n----rel freq: #{elem[:relative_frequency]}\n\n"}
  end
end