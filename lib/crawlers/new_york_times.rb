class NewYorkTimes < Crawler
  def self.crawl
    resque = Resque.new
    resque << ScoreURL.new(url)
  end
end