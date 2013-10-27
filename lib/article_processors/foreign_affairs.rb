module ForeignAffairsArticleProcessor
  
  def process_foreign_affairs(article)
    raise "NO URL FOUND FOR ARTICLE - #{article.url}" if article.url.nil? || article.url.empty?
    a = Article.first_or_new(:url => article.url)
    a.title = article.title
    a.content = Nokogiri::HTML(article.summary).search("p").collect{|p| p.text}.join(" ")
    a.publisher_code = "foreign_affairs"
    a.published_at = Time.now
    article.author ||= "Foreign Affairs"
    authors = extract_authors(article.author, a.id)
    a.author_ids = authors.collect(&:id)
    a.foreign_affairs = ForeignAffairsArticle.new_from_raw(article)
    a.save
    a
  end
  
end
