class Account
  include MongoMapper::Document
  key :ego_id, ObjectId
  key :domain, String
  key :alias, String
  key :print_alias, String
  key :credentials, Hash
  key :data
  belongs_to :ego

  def self.create_account_for(domain, credentials, ego_id)
    acct_alias = credentials.delete(:acct_alias)
    print_alias = credentials.delete(:print_alias)
    account = Account.first_or_create(:alias => acct_alias, :domain => domain, :ego_id => ego_id)
    account.credentials = credentials
    account.print_alias = print_alias
    ego = Ego.find(ego_id)
    ego.account_ids << account.id
    account.save
    ego.save
    account.collect_data
  end
  
  def collect_data
    case self.domain
    when "twitter"
      TwitterCrawlTweets.perform_async(self.credentials)
      TwitterCrawlGraph.perform_async(self.credentials, "friend")
      TwitterCrawlGraph.perform_async(self.credentials, "follower")
    end
  end
end