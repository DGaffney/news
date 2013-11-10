# class RetrainArticleEgoHitScores
#   include Sidekiq::Worker
#   
#   def perform
#     ArticleEgoHit.distinct(:ego_id).each do |ego_id|
#       limit = 1000
#       offset = 0
#       article_ego_hits = ArticleEgoHit.where(:ego_id => ego_id).fields(:article_ids).limit(limit).offset(offset).collect(&:article_ids)
#       article_ego_hits.each do |article_ego_hit|
#     end
#   end
# end