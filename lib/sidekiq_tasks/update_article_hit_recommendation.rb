class UpdateArticleHitRecommendation
  include Sidekiq::Worker

  def perform(ego_id)
    article_hit_scores = Hash[ArticleHit.fields(:article_id, :hit_count).where(:ego_id => BSON::ObjectId(ego_id)).collect{|article_hit| [article_hit.article_id, article_hit.hit_count]}]
    article_key_terms = Hash[Article.fields(:_id, :title).where(:_id => article_hit_scores.keys).collect{|article| [article.id, article.key_terms]}]
    term_scores = {}
    article_key_terms.each do |article_id, key_terms|
      key_terms.each do |term|
        if term_scores[term]
          term_scores[term] += article_hit_scores[article_id]
        else
          term_scores[term] = article_hit_scores[article_id]
        end
      end
    end
    terms = term_scores.sort_by{|k,v| v}.reverse.first(100).collect(&:first)
    articles = Article.fields(:id, :title, :created_at).where(:title => terms.collect{|term| /#{Regexp.escape(term)}/i})
    articles.each do |article|
      Score.first_or_create(:article_id => article.id, :ego_id => BSON::ObjectId(ego_id), :provenance => "article_hit", :article_created_at => article.created_at, :article_terms => article.key_terms).update_attributes(:value => term_scores.values_at(*article.key_terms).compact.sum)
      UpdateArticleEgoScore.perform_async(article.id, ego_id)
    end
  end
end