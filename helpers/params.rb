module ParamsHelper

  def pagination_conditions(params)
    {
      :order => params[:order]                                  || :created_at.desc,
      :per_page => params[:per_page] && params[:per_page].to_i  || 45,
      :page => params[:page] && params[:page].to_i              || 1
    }
  end

  def news_locals(conditions)
    {
      :articles => Articles.paginate(conditions),
      :page => conditions.page,
      :next => !Article.paginate(conditions.merge(:page => conditions[:page]+1)).empty?,
      :previous => conditions[:page] != 1 && !Article.paginate(conditions.merge(:page => conditions[:page]-1)).empty?,
      :html_page_title => "The News", 
      :page_title => "The News"
    }
  end
  
end