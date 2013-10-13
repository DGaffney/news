class NewYorkTimes < Crawler
  
  def self.crawl
    @newswire_api_key = Setting.nytimes_newswire_api_key
    offset = 0
    nyt = self.most_recent_temporal
    
    loop do

      nyt.results.each do |article|
        print "."
        ScoreURL.perform_async(article.url)
        ProcessArticle.perform_async(article, "new_york_times")
      end

      (offset + 20) >= nyt.num_results ? break : offset += 20
      nyt = self.most_recent_temporal(offset) 
    end
  end
  
  def self.select_fields(article, source_id)
    return {:title => article.title, :abstract => article.abstract, :url => article.url, :source_id => source_id, :created_at => Time.parse(article.created_date)}
  end

  def self.most_recent_linear(offset=0)
    @base_url = "http://api.nytimes.com/svc/news/v3/content/all/all.json"
    return Hashie::Mash[JSON.parse(RestClient.get(@base_url+"?api-key="+@newswire_api_key+"&offset=#{offset}"))]
  end

  def self.most_recent_temporal(offset=0, hrs=24)
    @base_url = "http://api.nytimes.com/svc/news/v3/content/all/all/#{hrs}.json"
    return Hashie::Mash[JSON.parse(RestClient.get(@base_url+"?api-key="+@newswire_api_key+"&offset=#{offset}"))]
  end

  def self.specific_article_details(url)
    @base_url = "http://api.nytimes.com/svc/news/v3/content.json"
    return Hashie::Mash[JSON.parse(RestClient.get(@base_url+"?api-key=#{@newswire_api_key}&url="+url.gsub("/", "%2F")))].results
  end
end