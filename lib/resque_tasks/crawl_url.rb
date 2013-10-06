require 'nokogiri'
class ProcessTweet
  include Sidekiq::Worker  
  def perform(url, account_id, tweet)
    Nokogiri.parse(RestClient.get(url))
  end
end