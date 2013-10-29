class AnalyzeTweets
  include Sidekiq::Worker
  def perform(credentials)
    account = Account.fields(:_id).where(:credentials => credentials).first
    twitter_bag_of_words = Provider::Twitter::Tweet.fields(:text).where(:account_id => BSON::ObjectId(account_id)).collect(&:text).join(" ").remove_stopwords.split.uniq
    datapoint = AccountDatapoint.first_or_create(:account_id => account.id, :provenance => "twitter_bag_of_words")
    datapoint.value = twitter_bag_of_words
    datapoint.save
    raw_topics = Topic.fields(:topic, :score).where(:related_term => twitter_bag_of_words).order(:score.desc).limit(30000).collect{|t| [t.topic, t.score]}
    twitter_account_topics = {}
    raw_topics.each do |t|
      twitter_account_topics[t.first.gsub(".", "")] ||= 0
      twitter_account_topics[t.first.gsub(".", "")] += t.last
    end
    datapoint = AccountDatapoint.first_or_create(:account_id => account.id, :provenance => "twitter_account_topics")
    datapoint.value = twitter_account_topics
    datapoint.save
    raise "Account Not Found!" if account.nil?
    Article.fields(:_id).each do |article|
      ScoreTweetForArticle.perform_async(article.id, account.id)
    end
  end
end