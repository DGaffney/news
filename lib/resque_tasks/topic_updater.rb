class TopicUpdater
  include NewYorkTimesArticleProcessor
  include GuardianArticleProcessor
  include Sidekiq::Worker
  
  def perform(article, provenance)
    self.send("update_topics_#{provenance}", article)
  end
end