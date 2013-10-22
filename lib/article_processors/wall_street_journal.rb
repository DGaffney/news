module WallStreetJournalArticleProcessor
  
  def process_wall_street_journal(article)
    raise "NO URL FOUND FOR ARTICLE - #{article.actual_url}" if article.actual_url.nil? || article.actual_url.empty?
    a = Article.first_or_new(:url => article.actual_url)
    a.title = article.title
    a.content = article.summary
    a.publisher_code = "wall_street_journal"
    a.published_at = Time.parse(article.published)
    article.author ||= "Wall Street Journal"
    authors = extract_authors(article.author, a.id)
    a.author_ids = authors.collect(&:id)
    a.wall_street_journal = WallStreetJournalArticle.new_from_raw(article)
    a.save
  end
  
end