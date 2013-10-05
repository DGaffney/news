require 'twitter'
class Importer::Twitter
  attr_accessor :credentials, :client
  def initialize(credentials)
    @client = Twitter::Client.new(credentials)
    @credentials = credentials
  end
  
  def graph(direction)
  end
  
  def tweets
    statuses = []
    status_set = Cache.get("user_timeline", "twitter", {count: 200, credentials: @credentials})
    user = Cache.get("user", "twitter", {credentials: @credentials})
    while !status_set.empty?
      statuses = status_set|statuses;false
      max_id = status_set.last.id-1
      status_set = Cache.get("user_timeline", "twitter", {count: 200, max_id: max_id, credentials: @credentials})
    end
    Resque.enqueue(ProcessAccount, credentials, user, "twitter")
    statuses.each do |status|
      Resque.enqueue(ProcessTweet, credentials, status, statuses.count, user)
    end
  end
  
  def self.process_account
    
  end
end