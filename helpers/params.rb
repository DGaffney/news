module ParamsHelper

  def pagination_conditions(params)
    {
      :order => params[:order]                                  || :created_at.desc,
      :per_page => params[:per_page] && params[:per_page].to_i  || 68,
      :page => params[:page] && params[:page].to_i              || 1
    }
  end

  def news_locals(conditions)
    params.start_range ||= params.time.nil? ? Time.parse(Time.now.ymd) : Time.parse(params[:time].split(" - ").first)
    params.end_range ||= params.time.nil? ? Time.parse(Time.now.ymd+" 23:59:59") : Time.parse(params[:time].split(" - ").last+" 23:59:59")
    article_ids = Score.a_priori_limit_offset(params).paginate(paginate(conditions)).collect(&:article_id)
    
    articles = Hash[Article.where(:id => article_ids).collect{|a| [a.id, a]}]
    {
      :articles => article_ids.collect{|article_id| articles[article_id]},
      :page => paginate(conditions)[:page],
      :next_page => true,
      :previous_page => paginate(conditions)[:page] != 1,
      :html_page_title => "The News", 
      :page_title => "The News",
      :start_range => params.start_range,
      :end_range => params.end_range
    }
  end
  
  def where(conditions)
    conditions.dup.delete_if{|k,v| [:order, :per_page, :page].include?(k)}
  end
  
  def paginate(conditions)
    Hash[[:page, :per_page].zip(conditions.dup.values_at(:page, :per_page))]
  end
  
  def order(conditions)
    conditions.dup[:order]
  end

end