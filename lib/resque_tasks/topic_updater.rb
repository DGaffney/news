class TopicUpdater
  include NewYorkTimesArticleProcessor
  include Sidekiq::Worker
  def perform(content, provenance)
    self.send("update_topics_#{provenance}", Hashie::Mash[article])
  end
end