module PoliticoArticleProcessor
  
  def process_politico(article)
    raise "NO URL FOUND FOR ARTICLE - #{article.url}" if article.entry_id.nil? || article.entry_id.empty?
    a = Article.first_or_new(:url => article.url)
    a.title = article.title
    a.content = article.summary
    a.publisher_code = "politico"
    a.published_at = Time.parse(article.published)
    article.author ||= "Politico"
    authors = extract_authors(article.author, a.id)
    a.author_ids = authors.collect(&:id)
    a.politico = PoliticoArticle.new_from_raw(article)
    a.save
  end
  
end