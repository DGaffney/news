class AnalyzeTweets
  include Sidekiq::Worker
  def perform(credentials)
    account = Account.fields(:_id).where(:credentials => credentials).first
    raise "Account Not Found!" if account.nil?
    Provider::Twitter::Tweet.fields(:_id).where(:account_id => account.id).each do |tweet|
      Article.fields(:_id).each do |article|
        ScoreTweetForArticle.perform_async(article.id, account.id, tweet.id)
      end
    end
  end
end