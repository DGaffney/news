module EconomistArticleProcessor
  
  def process_economist(article)
    raise "NO URL FOUND FOR ARTICLE - #{article.url}" if article.entry_id.nil? || article.entry_id.empty?
    a = Article.first_or_new(:url => article.entry_id)
    a.title = article.title
    a.content = Nokogiri::HTML(article.summary).content.gsub(" Read full article >>", "")
    a.publisher_code = "washington_post"
    a.published_at = Time.parse(article.published)
    article.author ||= "Washington Post"
    authors = extract_authors(article.author, a.id)
    a.author_ids = authors.collect(&:id)
    a.washington_post = WashingtonPostArticle.new_from_raw(article)
    a.save
  end
  
end