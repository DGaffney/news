require 'stopwords'
require 'stopwords/filter'
require 'stopwords/snowball'
require 'cld'

class String
  CURRENT_STOPWORD_LOCALES = [:bg, :da, :de, :en, :es, :fn, :fr, :hu, :it, :nl, :pt, :ru, :sv]
  def remove_stopwords
    sieve = Stopwords::Snowball::WordSieve.new
    filtered = nil
    lang = self.language
    if lang.nil? || !CURRENT_STOPWORD_LOCALES.include?(lang)
      filtered = sieve.filter lang: :en, words: self.split
    else
      filtered = sieve.filter lang: lang, words: self.split
    end
    filtered.join(" ")
  end

  def language
    lang = CLD.detect_language(self)
    return lang[:code].to_sym if lang[:reliable]
    return nil
  end
end