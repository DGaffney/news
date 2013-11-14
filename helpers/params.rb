module ParamsHelper

  def pagination_conditions(params)
    {
      :order => params[:order]                                  || :created_at.desc,
      :per_page => params[:per_page] && params[:per_page].to_i  || 68,
      :page => params[:page] && params[:page].to_i              || 1
    }
  end

  def news_locals(params)
    params.start_range ||= params.time.nil? ? Time.parse((Time.now-60*60*24*7).ymd) : Time.parse(params[:time].split(" - ").first)
    params.end_range ||= params.time.nil? ? Time.parse(Time.now.ymd+" 23:59:59") : Time.parse(params[:time].split(" - ").last+" 23:59:59")
    params.personal_relevance = params.personal_relevance.nil? ? 0 : params.personal_relevance.to_f/100
    params.objective_importance = params.objective_importance.nil? ? 0 : params.objective_importance.to_f/100
    personal_relevance_article_ids = current_ego.nil? ? {} : Hash[Score.scores_for_ego(current_ego, params)]
    objective_importance_article_ids = Hash[Score.scores_for_popularity(params)]
    articles = Hash[Article.where(:id => (objective_importance_article_ids.keys+personal_relevance_article_ids.keys).uniq).fields(:title, :url, :_id, :content, :publisher_code).collect{|a| [a.id, a]}]
    scores = {}
    articles.keys.each do |article_id|
      personal_relevance_score = personal_relevance_article_ids[article_id]*params.personal_relevance rescue 0
      objective_importance_score = objective_importance_article_ids[article_id]*params.objective_importance rescue 0
      scores[article_id] = personal_relevance_score+objective_importance_score
    end
    sorted_articles = []
    scores.sort_by{|k,v| v}.reverse.each do |article_id, score|
      sorted_articles << articles[article_id]
    end
    {
      :articles => sorted_articles.first(params.per_page),
      :page => params.page,
      :next_page => true,
      :previous_page => params.page != 1,
      :html_page_title => "The News", 
      :page_title => "The News",
      :start_range => params.start_range,
      :end_range => params.end_range,
      :query => params[:query]
    }
  end
end