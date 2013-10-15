module GuardianArticleProcessor
  
  def process_guardian(article)
    a = Article.first_or_new(:url => article.webUrl)

    if article.fields.byline
      authors = extract_authors(article.fields.byline, a.id)
      a.author_ids = authors.collect(&:id)
    end

    a.title = article.webTitle
    a.publisher_code = "guardian"
    a.guardian = GuardianArticle.new_from_raw(article)
    a.published_at = a.guardian.web_publication_date
    a.content = article.fields.standfirst rescue nil
    a.save!
  end
end