class ProcessArticle
  include ArticleProcessor
  include NewYorkTimesArticleProcessor
  include GuardianArticleProcessor
  include NPRArticleProcessor
  include AtlanticWireArticleProcessor
  include MotherJonesArticleProcessor
  include HuffingtonPostArticleProcessor
  include Sidekiq::Worker
  
  def perform(article, provenance)
    self.send("process_#{provenance}", Hash[article])
  end
  
end