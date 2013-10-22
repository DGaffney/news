module ChristianScienceMonitorArticleProcessor
  
  def process_christian_science_monitor(article)
    raise "NO URL FOUND FOR ARTICLE - #{article.id}" if article.url.nil? || article.url.empty?
    a = Article.first_or_new(:url => article.url)
    a.title = article.title
    a.content = Nokogiri::HTML(article.summary).content
    a.publisher_code = "christian_science_monitor"
    a.published_at = Time.now
    article.author ||= "Christian Science Monitor"
    authors = extract_authors(article.author, a.id)
    a.author_ids = authors.collect(&:id)
    a.christian_science_monitor = ChristianScienceMonitorArticle.new_from_raw(article)
    a.save
  end
  
end