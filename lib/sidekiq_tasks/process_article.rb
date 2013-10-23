class ProcessArticle
  include ArticleProcessor
  include NewYorkTimesArticleProcessor
  include GuardianArticleProcessor
  include NPRArticleProcessor
  include AtlanticWireArticleProcessor
  include MotherJonesArticleProcessor
  include HuffingtonPostArticleProcessor
  include ReutersArticleProcessor
  include ChristianScienceMonitorArticleProcessor
  include BBCNewsArticleProcessor
  include WashingtonPostArticleProcessor
  include SalonArticleProcessor
  include WallStreetJournalArticleProcessor
  include PoliticoArticleProcessor
  include EconomistArticleProcessor
  include SlateArticleProcessor
  include ForeignAffairsArticleProcessor
  include Sidekiq::Worker
  
  def perform(article, provenance)
    self.send("process_#{provenance}", Hash[article])
  end
  
end