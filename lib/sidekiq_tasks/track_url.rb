class TrackURL
  include Sidekiq::Worker
  
  def perform(article_id, ego_id)
    ego_id = nil if ego_id == "none"
    ArticleHit.first(:article_id => article_id, :ego_id => ego_id).increment
  end
end