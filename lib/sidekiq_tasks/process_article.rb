class ProcessArticle
  include NewYorkTimesArticleProcessor
  include GuardianArticleProcessor
  include Sidekiq::Worker
  
  def perform(article, provenance)
    self.send("process_#{provenance}", Hashie::Mash[article])
  end
end