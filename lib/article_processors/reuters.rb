module ReutersArticleProcessor
  
  def process_reuters(article)
    raise "NO URL FOUND FOR ARTICLE - #{article.entry_id}" if article.url.nil? || article.url.empty?
    a = Article.first_or_new(:url => article.entry_id)
    a.title = article.title
    a.content = Nokogiri::HTML(article.summary).content
    a.publisher_code = "reuters"
    a.published_at = Time.parse(article.published)
    article.author ||= "Reuters Wire"
    authors = extract_authors(article.author, a.id)
    a.author_ids = authors.collect(&:id)
    a.reuters = ReutersArticle.new_from_raw(article)
    a.save
    a
  end
  
end