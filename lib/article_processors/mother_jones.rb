module MotherJonesArticleProcessor
  
  def process_mother_jones(article)
    raise "NO URL FOUND FOR ARTICLE - #{article.id}" if article.url.nil? || article.url.empty?
    a = Article.first_or_new(:url => article.url)
    a.title = article.title
    a.content = Nokogiri.parse(article.summary).search("body").children.search("p").first.text rescue nil
    a.publisher_code = "mother_jones"
    a.published_at = article.published
    article.author ||= "Mother Jones"
    authors = extract_authors(article.author, a.id)
    a.author_ids = authors.collect(&:id)
    a.mother_jones = MotherJonesArticle.new_from_raw(article)
    a.save
    a
  end
  
end