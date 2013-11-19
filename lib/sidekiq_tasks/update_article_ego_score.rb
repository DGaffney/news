class UpdateArticleEgoScore
  include Sidekiq::Worker
  def perform(article_id, ego_id)
    scores = Score.fields(:value, :provenance, :article_created_at, :article_terms).where(:article_id => article_id, :ego_id => ego_id)
    article_created_at = scores.first.article_created_at
    article_terms = scores.first.article_terms
    score_percentiles = {}
    scores.each do |score|
      values = Score.fields(:value).where(:provenance => score.provenance, :ego_id => ego_id).order(:_rand).limit(1000).collect(&:value)
      score_percentiles[score.provenance] = values.reverse_percentile(score.value)
    end
    Score.first_or_create(:article_id => BSON::ObjectId(article_id), :ego_id => BSON::ObjectId(ego_id), :provenance => "personal_score", :article_created_at => article_created_at, :article_terms => article_terms).update_attributes(:value => score_percentiles.values.compact.average)
  end
end