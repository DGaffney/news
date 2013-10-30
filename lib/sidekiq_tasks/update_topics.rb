class UpdateTopics
  include Sidekiq::Worker
  def perform(article_id)
    article = Article.find(article_id)
    key_terms = article.key_terms
    categories = article.categories
    categories.each do |category|
      key_terms.each do |key_term|
        next if key_term == category
        Topic.first_or_create(:topic => category, :related_term => key_term)
        Topic.increment({:topic => category, :related_term => key_term}, :score => 1)
      end
    end
    article_topics = Topic.fields(:topic).where(:related_term => key_terms).order(:score.desc).limit(30000).collect(&:topic)
    article_datapoint = ArticleDatapoint.first_or_create(:article_id => article.id, :provenance => "article_topics")
    article_datapoint.value = article_topics
    article_datapoint.save
  end
end