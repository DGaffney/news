class TopicUpdater
  include ArticleProcessor
  include Sidekiq::Worker
  
  def perform(article, provenance)
    self.send("update_topics", article, provenance)
  end
end