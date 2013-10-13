require 'nokogiri'

class ProcessTweet
  include Sidekiq::Worker
  
  def perform(url, account_id, provenance, provenance_id)
    URLTitle.first_or_create(title: Nokogiri.parse(RestClient.get(url)).title, account_id: account_id, provenance: provenance, provenance_id: provenance_id)
  end
end