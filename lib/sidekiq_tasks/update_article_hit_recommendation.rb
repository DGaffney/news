class UpdateArticleHitRecommendation
  include Sidekiq::Worker
  
  def perform
    ArticleHit.distinct(:article_id).each do |article_id|
      distinct_egos = ArticleHit.distinct(:ego_id, {:article_id => article_id}).reject(&:nil?)
      distinct_articles = ArticleHit.distinct(:article_id, {:ego_id => distinct_egos})
      Score.first_or_create(:article_id => article.id, :ego_id => ego_id, :provenance => "hit", :article_created_at => article.created_at)
      Score.increment({:article_id => article.id, :ego_id => ego_id, :provenance => "article_tweet_score", :article_created_at => article.created_at}, :value => (article_topics&topics).length.to_f/topics.length)
      
    end
  end
end
