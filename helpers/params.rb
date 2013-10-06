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
      :articles => Article.where(where(conditions)).order(order(conditions)).paginate(paginate(conditions)),
      :page => paginate(conditions)[:page],
      :next_page => !Article.where(where(conditions)).order(order(conditions)).paginate(paginate(conditions).merge(:page => paginate(conditions)[:page]+1)).empty?,
      :previous_page => paginate(conditions)[:page] != 1 && !Article.where(where(conditions)).order(order(conditions)).paginate(paginate(conditions).merge(:page => paginate(conditions)[:page]-1)).empty?,
      :html_page_title => "The News", 
      :page_title => "The News"
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