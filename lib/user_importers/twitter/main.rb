require 'twitter'
class Importer::Twitter
  attr_accessor :credentials, :client
  def initialize(credentials)
    @client = Twitter::Client.new(credentials)
    @credentials = credentials
  end
  
  def graph(direction)
    account = Account.where(credentials: @credentials).first
    cursor = -1
    while cursor != 0
      initial = Cache.get("#{direction}_ids", "twitter", {credentials: @credentials, cursor: cursor})
      id_set = Provider::Twitter::Relationship.new_from_raw(initial, account.id, direction)
      id_set.save
      cursor = initial.next_cursor
    end
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
    ProcessAccount.perform_async(credentials, user, "twitter")
    statuses.each do |status|
      ProcessTweet.perform_async(credentials, status, statuses.count, user)
    end
  end

  def process_account(user)
    account = Account.where(credentials: @credentials).first
    Provider::Twitter::User.new_from_raw(user, account.id).save
  end
end