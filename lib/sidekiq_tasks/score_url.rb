class ScoreURL
  include Sidekiq::Worker
  
  def perform(article_id)
    article = Article.find(article_id) || Article.first(:url => article_id)
    SharedCountScorer.store_raw(article.url)
    # BitlyScorer.store_raw(url)
    RankURL.perform_async(article.id)
    ScoreURL.perform_in(1.day, article.id)
  end
end