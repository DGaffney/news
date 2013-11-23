class ScoreURL
  include Sidekiq::Worker
  
  def perform(article_id)
    article = Article.find(article_id) || Article.first(:url => article_id)
    return nil if article.created_at < Time.now-60*60*24*7*4
    SharedCountScorer.store_raw(article.url)
    # BitlyScorer.store_raw(url)
    RankURL.perform_async(article.id)
    ScoreURL.perform_in(1.day, article.id)
  end
end