module NewsParamsHelper
  def time_range(params)
    params[:time] = "#{Article.earliest_time_range} - #{Article.latest_time_range}" if params[:time].nil?
    {:article_created_at.gte => Time.parse(params[:time].split(" - ").first), :article_created_at.lte => Time.parse(params[:time].split(" - ").last)}
  end
  
  def a_priori_score(params)
    
  end
end