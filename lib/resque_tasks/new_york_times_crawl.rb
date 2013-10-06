class NewYorkTimesCrawl
  include Sidekiq::Worker
  def self.perform
    NewYorkTimes.crawl
  end
end