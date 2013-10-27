class ScoreTweetForArticle
  include Sidekiq::Worker
  def perform(article_id, account_id, tweet_id)
    article_tags = Article.tags_for(article_id)
    tweet_tags = Provider::Twitter::Tweet.tags_for(tweet_id)
  end
end