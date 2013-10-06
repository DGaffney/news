class ProcessArticle
  extend NewYorkTimesArticleProcessor
  include Sidekiq::Worker
  def self.perform(article, source)
    self.send("process_#{source}", Hashie::Mash[article])
  end
end