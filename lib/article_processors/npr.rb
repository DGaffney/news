module NPRArticleProcessor
  
  def process_npr(article)
    a = Article.first_or_new(:url => article.links.first.content)
    a.title = article.title
    a.content = article.teaser
    a.publisher_code = "npr"
    a.published_at = Time.parse(article.pubDate)
    a.npr = NPRArticle.new_from_raw(article)
    authors = article.bylines.empty? ? "NPR Staff" : article.bylines.collect(&:name).collect(&:content).collect(&:to_s).join(" and ") rescue "NPR Staff"
    authors = extract_authors(authors, a.id)
    a.author_ids = authors.collect(&:id)
    a.save
    a
  end
  
end