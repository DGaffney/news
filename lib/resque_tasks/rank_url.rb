class RankURL
  include Sidekiq::Worker
  def perform(url)
    bitly_score = BitlyScorer.percentile(url)
    shared_count_scores = SharedCountScorer.percentile(url)
    score = shared_count_scores.values
    score << bitly_score
    article = Article.first_or_create(url: url)
    Score.first_or_create(article_id: article.id, provenance: "score_url", value: score.average)
    RankURL.perform_in(1.day, url)
  end
end