class ProcessTweet
  include Sidekiq::Worker  
  def perform(credentials, status, statuses_count, user)
    account = Account.first(credentials: credentials)
    Provider::Twitter::Tweet.new_from_raw(status.merge(account_id: account.id)).save
    AnalyzeTweets.perform_async(credentials) if statuses_count == Provider::Twitter::Tweet.where(account_id: account.id).count
  end
end