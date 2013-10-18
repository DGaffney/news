require 'nokogiri'
class CrawlURL
  include Sidekiq::Worker  
  def perform(url, account_id, provenance, provenance_id)
    title = Nokogiri.parse(RestClient.get(url)).search("title").children.text rescue nil
    URLTitle.first_or_create(title: title, account_id: account_id, provenance: provenance, provenance_id: provenance_id) if title
  end
end