module GuardianArticleProcessor
  def process_guardian(article)
    a = Article.first_or_new(:url => article.url)
    a.title = article.webTitle
    authors = extract_guardian_authors(article.fields.byline, a.id)
    a.author_ids = authors.collect(&:id)
    a.content = article.fields.standfirst
    a.publisher_code = "guardian"
    a.guardian = GuardianArticle.new_from_raw(article)
    a.published_at = a.guardian.web_publication_date
    TopicUpdater.perform_async(a.guardian.attributes, "guardian")
    a.save!
  end

  def extract_guardian_authors(byline, article_id)
    separators = [" and ", ", and ", ", "]
    authors = []
    
    byline.gsub(/^By /, "").split(/( and |, and |, )/).reject(&:empty?).reject{|a| separators.include?(a)}.each do |author|
      if author.split(" ").length == 2
        full_name = author.split(" ").collect(&:capitalize).join(" ") rescue author
        first_name = author.split(" ").first.capitalize rescue nil
        last_name = author.split(" ").last.capitalize rescue nil
        authors << {:first_name => first_name, :last_name => last_name, :full_name => full_name}
      elsif author.upcase == author
        full_name = author.split(" ").collect(&:capitalize).join(" ") rescue author
        authors << {:full_name => full_name, :first_name => nil, :last_name => nil}
      else
        full_name = author.split(" ").collect(&:capitalize).join(" ") rescue author
        authors << {:full_name => full_name, :first_name => nil, :last_name => nil}
      end
    end
    
    authors.collect do |author|
      author = Author.first_or_create(author)
      author.article_ids << article_id
      author.save!
      author
    end
  end

  def update_topics_guardian(article)
  end
  
  def generate_topics_guardian(article)
  end
end