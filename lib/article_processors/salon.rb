module SalonArticleProcessor
  
  def process_salon(article)
    url = Nokogiri::HTML(article.content).search("a").select{|a| a.text == "Continue Reading..."}.first.attributes.href.value rescue nil
    raise "NO URL FOUND FOR ARTICLE - #{article.entry_id}" if url.nil? || url.empty?
    a = Article.first_or_new(:url => url)
    a.title = article.title
    a.content = Nokogiri::HTML(article.content).search("p").text.gsub("Continue Reading...", "")
    a.publisher_code = "salon"
    a.published_at = Time.parse(article.published)
    article.author ||= "Salon"
    authors = extract_authors(article.author, a.id)
    a.author_ids = authors.collect(&:id)
    a.salon = SalonArticle.new_from_raw(article)
    a.save
    a
  end
  
end