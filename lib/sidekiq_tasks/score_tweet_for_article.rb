class ScoreTweetForArticle
  include Sidekiq::Worker
  def perform(article_id, account_id, tweet_id)
    article_topics = Topic.fields(:topic).where(:related_term => Article.find(article_id).key_terms).order(:score.desc).limit(100).collect(&:topic)
    tweet_topics = Topic.fields(:topic).where(:related_term => Provider::Twitter::Tweet.find(tweet_id).text.remove_stopwords.split).order(:score.desc).limit(100).to_a.collect(&:topic)
    ego_id = Ego.fields(:_id).where(:account_ids => account_id).first.id
    Score.first_or_create(:article_id => article_id, :ego_id => ego_id, :provenance => "article_tweet_score")
    Score.increment({:article_id => article_id, :ego_id => ego_id, :provenance => "article_tweet_score"}, :score => (article_topics&tweet_topics).length/(article_topics|tweet_topics).length.to_f)
  end
end