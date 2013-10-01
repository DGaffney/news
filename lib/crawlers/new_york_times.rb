class NewYorkTimes < Crawler
  def self.crawl(periodicity=60*60*24)
    @newswire_api_key = Setting.nytimes_newswire_api_key
    offset = 0
    articles = self.most_recent_linear(offset)
    newest = Time.parse(articles.first.updated_date)
    finished = false
    while !finished
      articles.each do |article|
        print "."
        # next if finished
        Resque.enqueue(ScoreURL, article.url)
        Resque.enqueue(ProcessArticle, article, "new_york_times")
        # finished = true if Time.parse(article.updated_date) < newest-periodicity
      end
      offset += 20
      articles = self.most_recent_linear(offset) if !finished
    end
  end
  
  def self.select_fields(article, source_id)
    return {:title => article.title, :abstract => article.abstract, :url => article.url, :source_id => source_id, :created_at => Time.parse(article.created_date)}
  end

  def self.most_recent_linear(offset=0)
    @base_url = "http://api.nytimes.com/svc/news/v3/content/all/all.json"
    return Hashie::Mash[JSON.parse(RestClient.get(@base_url+"?api-key="+@newswire_api_key+"&offset=#{offset}"))].results
  end

  def self.most_recent_temporal(hrs="all")
    @base_url = "http://api.nytimes.com/svc/news/v3/content/all/#{hrs}.json"
    return Hashie::Mash[JSON.parse(RestClient.get(@base_url+"?api-key="+@newswire_api_key))].results
  end

  def self.specific_article_details(url)
    @base_url = "http://api.nytimes.com/svc/news/v3/content.json"
    return Hashie::Mash[JSON.parse(RestClient.get(@base_url+"?api-key=#{@newswire_api_key}&url="+url.gsub("/", "%2F")))].results
  end
end