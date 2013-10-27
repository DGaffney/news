module HuffingtonPostArticleProcessor
  
  def process_huffington_post(article)
    raise "NO URL FOUND FOR ARTICLE - #{article.id}" if article.url.nil? || article.url.empty?
    a = Article.first_or_new(:url => article.url)
    a.title = article.title
    a.content = Nokogiri.parse(article.content).children.first.text rescue binding.pry
    a.publisher_code = "huffington_post"
    a.published_at = Time.parse(article.published)
    authors = extract_authors(article.author, a.id)
    a.author_ids = authors.collect(&:id)
    a.huffington_post = HuffingtonPostArticle.new_from_raw(article)
    a.save
    a
  end
  
end