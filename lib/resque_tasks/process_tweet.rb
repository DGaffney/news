class ProcessTweet
  @queue = :main
  
  def self.perform(credentials, status, statuses_count, user)
    binding.pry
    account = Account.first(credentials: credentials)
    Provider::Twitter::Tweet.new_from_raw(status)
    Resque.enqueue(AnalyzeTweets, credentials) if statuses_count == Provider::Twitter::Tweet.where(account_id: account.id).count
  end
end