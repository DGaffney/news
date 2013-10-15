module NewYorkTimesArticleProcessor
  
  def process_new_york_times(article)
    a = Article.first_or_new(:url => article.url)
    authors = extract_authors(article.byline, a.id)

    a.title = article.title
    a.content = article.abstract
    a.publisher_code = "new_york_times"
    a.new_york_times = NewYorkTimesArticle.new_from_raw(article)
    a.published_at = a.new_york_times.published_date
    a.author_ids = authors.collect(&:id)
    a.save!
  end
end