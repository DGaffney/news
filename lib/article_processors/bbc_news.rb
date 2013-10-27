module BBCNewsArticleProcessor
  
  def process_bbc_news(article)
    raise "NO URL FOUND FOR ARTICLE - #{article.id}" if article.url.nil? || article.url.empty?
    a = Article.first_or_new(:url => article.url)
    a.title = article.title
    a.content = article.summary
    a.publisher_code = "bbc_news"
    a.published_at = Time.parse(article.published)
    article.author ||= "BBC News"
    authors = extract_authors(article.author, a.id)
    a.author_ids = authors.collect(&:id)
    a.bbc_news = BBCNewsArticle.new_from_raw(article)
    a.save
    a
  end
  
end