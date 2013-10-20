module NPRArticleProcessor
  
  def process_npr(article)
    a = Article.first_or_new(:url => article.links.first.to_s)
    a.title = article.title
    a.content = article.teaser
    a.publisher_code = "npr"
    a.published_at = article.pubDate
    authors = article.bylines.empty? ? "NPR Staff" : article.bylines.collect(&:name).collect(&:to_s).join(" and ") rescue "NPR Staff"
    authors = extract_authors(authors, a.id)
    a.author_ids = authors.collect(&:id)
    a.npr = NPRArticle.new_from_raw(article)
    a.save
  end
  
end