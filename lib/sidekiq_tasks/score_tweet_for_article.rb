class ScoreTweetForArticle
  include Sidekiq::Worker
  def perform(article_id, account_id)
    article = Article.find(article_id)
    article_topics = ArticleDatapoint.first(:article_id => article.id, :provenance => "article_topics")
    if article_topics.nil? 
      UpdateTopics.perform_async(article_id)
      return nil
    else
      article_topics = article_topics.value
    end
    twitter_account_topics = AccountDatapoint.first(:account_id => BSON::ObjectId(account_id), :provenance => "twitter_account_topics").value
    half_elbow = twitter_account_topics.values.elbow_cutoff/2
    topics = twitter_account_topics.collect{|k,v| k if v >= half_elbow}.compact
    ego_id = Ego.fields(:_id).where(:account_ids => BSON::ObjectId(account_id)).first.id
    return nil if (article_topics&topics).length == 0 && topics.length == 0
    score = (article_topics&topics).length.to_f/topics.length
    if !score.is_nan?
      Score.first_or_create(:article_id => article.id, :ego_id => ego_id, :provenance => "article_tweet_score", :article_created_at => article.created_at, :article_terms => article.key_terms).update_attributes(:value => score)
      UpdateArticleEgoScore.perform_async(article.id, ego_id)
    end
  end
end
# accounts = Account.fields(:_id).where(:domain => "twitter")
# Article.fields(:_id).each do |article|
#   accounts.each do |account|
#     ScoreTweetForArticle.perform_async(article.id, account.id)
#   end
# end