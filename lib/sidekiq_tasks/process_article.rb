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
  include NewYorkerArticleProcessor
  include Sidekiq::Worker
  sidekiq_options :queue => :news_source  
  def perform(article, provenance)
    article = self.send("process_#{provenance}", Hash[article])
    UpdateTopics.perform_async(article.id)
    Account.where(:domain => "twitter").fields(:_id).each do |account|
      ScoreTweetForArticle.perform_async(article.id, account.id)
    end
    ScoreURL.perform_async(article.id)
  end
  
end