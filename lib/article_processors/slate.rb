module SlateArticleProcessor
  
  def process_slate(article)
    raise "NO URL FOUND FOR ARTICLE - #{article.url}" if article.url.nil? || article.url.empty?
    a = Article.first_or_new(:url => article.url)
    a.title = article.title
    a.content = article.summary
    a.publisher_code = "slate"
    a.published_at = Time.parse(article.published)
    article.author ||= "Slate"
    authors = extract_authors(article.author, a.id)
    a.author_ids = authors.collect(&:id)
    a.slate = SlateArticle.new_from_raw(article)
    a.save
    a
  end
  
end