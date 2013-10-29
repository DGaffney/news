class ScoreTweetsForArticle
  include Sidekiq::Worker
  def perform(article_id, account_id)
    article_topics = ArticleDatapoint.first(:account_id => BSON::ObjectId(article_id), :provenance => "article_topics").value
    twitter_bag_of_words = AccountDatapoint.first(:account_id => BSON::ObjectId(account_id), :provenance => "twitter_bag_of_words").value
    twitter_account_topics = AccountDatapoint.first(:account_id => BSON::ObjectId(account_id), :provenance => "twitter_account_topics").value
    half_elbow = twitter_account_topics.values.elbow_cutoff/2
    topics = twitter_account_topics.collect{|k,v| k if v >= half_elbow}.compact
    ego_id = Ego.fields(:_id).where(:account_ids => BSON::ObjectId(account_id)).first.id
    Score.first_or_create(:article_id => BSON::ObjectId(article_id), :ego_id => ego_id, :provenance => "article_tweet_score")
    Score.increment({:article_id => BSON::ObjectId(article_id), :ego_id => ego_id, :provenance => "article_tweet_score"}, :score => (article_topics&topics).length.to_f/topics.length)
  end
end