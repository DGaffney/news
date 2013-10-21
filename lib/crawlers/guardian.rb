class Guardian < Crawler
  
  def self.crawl
    @guardian_api_key = Setting.guardian_content_api_key
    yesterday = (Time.now-24*60*60*7*30).strftime("%Y-%m-%d")
    guardian = self.for_date(yesterday)
    
    loop do
      
      guardian.results.each do |article|
        print "."
        ScoreURL.perform_async(article.webUrl)
        ProcessArticle.perform_async(article, "guardian")
      end

      guardian.currentPage == guardian.pages ? break : next_page = guardian.currentPage + 1
      guardian = self.for_date(yesterday, next_page)
    end
  end

  def self.for_date(date, page=1)
    @base_url = "http://content.guardianapis.com/search"
    
    url = [
      @base_url,
      "?from-date=#{date}",
      "&page=#{page}",
      "&page-size=50",
      "&show-fields=all",
      "&show-tags=all",
      "&show-factboxes=all",
      "&show-references=all",
      "&show-refinements=all",
      "&api-key=#{@guardian_api_key}"
    ].join

    return Hash[JSON.parse(RestClient.get(url))].response
  end
  
end