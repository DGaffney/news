class RankURL
  include Sidekiq::Worker
  def perform(article_id)
    # bitly_score = BitlyScorer.percentile(url)
    article = Article.find(article_id) || Article.first(:url => article_id)
    shared_count_scores = SharedCountScorer.percentile(article.url)
    score = shared_count_scores.values
    # score << bitly_score
    Score.first_or_create(article_id: article.id, provenance: "score_url", value: score.average, article_created_at: article.published_at, :article_terms => article.key_terms)
    RankURL.perform_in(1.day, article.url)
  end
end
# Article.fields(:url).each do |article|
#   RankURL.perform_async(article.url)
# end