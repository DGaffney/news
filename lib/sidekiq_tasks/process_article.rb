class ProcessArticle
  include ArticleProcessor
  include NewYorkTimesArticleProcessor
  include GuardianArticleProcessor
  include NPRArticleProcessor
  include Sidekiq::Worker
  
  def perform(article, provenance)
    self.send("process_#{provenance}", Hashie::Mash[article])
  end
  
end