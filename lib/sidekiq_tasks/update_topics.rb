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
  end
end