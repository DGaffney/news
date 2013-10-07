class TopicUpdater
  include NewYorkTimesArticleProcessor
  include Sidekiq::Worker
  def perform(article, provenance)
    self.send("update_topics_#{provenance}", article)
  end
end