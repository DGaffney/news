module ParamsHelper

  def pagination_conditions(params)
    {
      :order => params[:order]                                  || :created_at.desc,
      :per_page => params[:per_page] && params[:per_page].to_i  || 45,
      :page => params[:page] && params[:page].to_i              || 1
    }
  end

  def news_locals(conditions)
    conditions = Hashie::Mash[conditions]
    where = conditions.dup
    paginate = conditions.dup
    where.delete(:page)
    where.delete(:per_page)
    where.delete(:order)
    order = conditions.order
    paginate.delete(:order)
    {
      :articles => Article.where(where).order(order).paginate(paginate),
      :page => paginate.page,
      :next_page => !Article.where(where).order(order).paginate(paginate.merge(:page => paginate.page+1)).empty?,
      :previous_page => paginate.page != 1 && !Article.paginate(paginate.merge(:page => paginate.page-1)).empty?,
      :html_page_title => "The News", 
      :page_title => "The News"
    }
  end
  
end