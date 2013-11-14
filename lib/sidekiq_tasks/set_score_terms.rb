class SetScoreTerms
  include Sidekiq::Worker
  
  def perform(score_id)
    score = Score.find(score_id)
    score.article_terms = score.article.key_terms
    score.save!
  end
end