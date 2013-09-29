get "/news"
  conditions = {}
  conditions[:order] = params[:order] || :created_at.desc
  conditions[:per_page] = params[:per_page] && params[:per_page].to_i ||25
  conditions[:page] = params[:page] && params[:page].to_i || 1
  @articles = Article.paginate(conditions.dup)
  @page = conditions[:page]
  @next = !Article.paginate(conditions.merge(:page => conditions[:page]+1)).empty?
  @previous = conditions[:page] != 1 && !Article.paginate(conditions.merge(:page => conditions[:page]-1)).empty?
  erb :"articles/index", :layout => :"layouts/main", :locals => {:html_page_title => "The News", :page_title => "The News"}
end