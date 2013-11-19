class TrackURL
  include Sidekiq::Worker
  
  def perform(article_id, ego_id)
    ego_id = nil if ego_id == "none"
    ArticleHit.first_or_create(:article_id => article_id, :ego_id => ego_id).increment
    ArticleHit.increment({:article_id => article_id, :ego_id => ego_id}, :hit_count => 1)
    UpdateArticleHitRecommendation.perform_async(ego_id)
  end
end