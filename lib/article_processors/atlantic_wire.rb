module AtlanticWireArticleProcessor
  
  def process_atlantic_wire(article)
    url = URI(URI.decode("http%3A%2F%2Fwww.theatlanticwire.com"+article.summary.split("www.theatlanticwire.com")[1].split("\"").first.split("&t=").first)).to_s rescue nil
    raise "NO URL FOUND FOR ARTICLE - #{article.id}" if url.nil? || url.empty?
    a = Article.first_or_new(:url => url)
    a.title = article.title
    a.content = Nokogiri.parse(article.content).children.first.text
    a.publisher_code = "atlantic_wire"
    a.published_at = article.published
    authors = extract_authors(article.author, a.id)
    a.author_ids = authors.collect(&:id)
    a.atlantic_wire = AtlanticWireArticle.new_from_raw(article)
    a.save
  end
  
end