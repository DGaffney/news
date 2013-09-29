class NewYorkTimesCrawl
  @queue = :main

  def self.perform
    NewYorkTimes.crawl
  end
end