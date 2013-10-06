class ProcessTweet
  include Sidekiq::Worker  
  def perform(credentials, status, statuses_count, user)
    account = Account.first(credentials: credentials)
    tweet = Provider::Twitter::Tweet.new_from_raw(status.merge(account_id: account.id)).save
    tweet.urls.each do |url|
      crawl_url = url.expanded_url || url.url || url.display_url
      CrawlURL.perform_async(crawl_url, account.id, "tweet") if crawl_url && !crawl_url.empty?
    end
    AnalyzeTweets.perform_async(credentials) if statuses_count == Provider::Twitter::Tweet.where(account_id: account.id).count
  end
end