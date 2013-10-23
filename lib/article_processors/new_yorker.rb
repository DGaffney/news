module NewYorkerArticleProcessor
  
  def process_new_yorker(article)
    raise "NO URL FOUND FOR ARTICLE - #{article.url}" if article.url.nil? || article.url.empty?
    a = Article.first_or_new(:url => article.url)
    a.title = article.title
    a.content = article.summary
    a.publisher_code = "new_yorker"
    a.published_at = Time.parse(article.published)
    article.author ||= "The New Yorker"
    authors = extract_authors(article.author, a.id)
    a.author_ids = authors.collect(&:id)
    a.new_yorker = NewYorkerArticle.new_from_raw(article)
    a.save
  end
  
end