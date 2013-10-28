require 'stopwords'
require 'stopwords/filter'
require 'stopwords/snowball'
require 'lingua/stemmer'
require 'cld'

class String
  CURRENT_STOPWORD_LOCALES = [:bg, :da, :de, :en, :es, :fn, :fr, :hu, :it, :nl, :pt, :ru, :sv]
  def remove_stopwords
    filtered = []
    lang = self.language
    self.split.each do |term|
      filtered << term if !term.stopword?(lang)
    end
    filtered.join(" ")
  end
  
  def stopword?(lang=:en)
    lang||=:en
    sieve = Stopwords::Snowball::WordSieve.new
    sieve.filter(lang: lang, words: [self.downcase]).empty? || matches_additional_stopwords(lang=:en)
  end

  def matches_additional_stopwords(lang=:en)
    additional_stopwords(lang) && additional_stopwords(lang).collect(&:stem).include?(self.downcase.stem)
  end

  def stem(lang=:en)
    stemmer = Lingua::Stemmer.new(:language => lang)
    stemmer.stem(self)
  end

  def language
    lang = CLD.detect_language(self)
    return lang[:code].to_sym if lang[:reliable]
    return nil
  end
  
  def additional_stopwords(lang=:en)
    stopwords = {:en => ["new", "case", "will", "says", "dies", "world", "back", "deal", "take", "win", "may", "can", "big", "two", "first", "high", "court", "end", "gets", "house", "finds", "week", "talks", "day", "top", "open", "without", "start", "time", "white", "oct", "years", "now", "global", "face", "help", "get", "love", "set", "another", "reach", "health", "cost", "faces", "last", "say", "still", "calls", "making", "right", "party", "year", "many", "seeking", "next", "says"]}
    set = (stopwords[:en]|self.domain_specific_stopwords)
    set|set.collect{|term| term.stem(lang)}
  end
  
  def domain_specific_stopwords
    return []
  end
end