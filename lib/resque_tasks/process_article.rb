class ProcessArticle
  extend NewYorkTimesArticleProcessor
  @queue = :main

  def self.perform(article, source)
    self.send("process_#{source}", article)
  end
end