class Guardian < Crawler
  
  def self.crawl
    @guardian_api_key = Setting.guardian_content_api_key
    yesterday = Date.yesterday.strftime("%Y-%m-%d")
    guardian_reponse = self.day(yesterday)
    
    while guardian_response.current_page <= guardian_response.pages
      articles = guardian_response.results
      
      articles.each do |article|
        print "."
        ScoreURL.perform_async(article.webUrl)
        ProcessArticle.perform_async(article, "guardian")
      end

      next_page = guardian_response.current_page + 1
      guardian_reponse = self.day(yesterday, next_page)
    end

  end

  def self.day(date, page=1)
    @base_url = "http://content.guardianapis.com/search"
    
    url = [
      @base_url,
      "?from-date=", date,
      "&page=", page,
      "&page-size=50",
      "&show-fields=all",
      "&show-tags=all",
      "&show-factboxes=all",
      "&show-references=all",
      "&show-refinements=all",
      "&api-key=", @guardian_api_key
    ].join

    return Hashie::Mash[JSON.parse(RestClient.get(url))].response
  end
end