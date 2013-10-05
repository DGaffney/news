before do
  authenticate_for(current_ego, :path => request.path, :method => request.env["REQUEST_METHOD"], :params => params)
end

before "/admin/:model" do
  params[:page] ||= 1
  params[:per_page] ||= 25
  @model = params[:model].classify.constantize
  @objects = @model.paginate(:page => params[:page], :per_page => params[:per_page])
  @keys = @model.admin_table_keys
  @erb_path = erb_path_for("admin_index")
end

before "/admin/:model/:id" do
  @model = params[:model].classify.constantize
  @object = @model.find(params[:id])
  @keys = @model.admin_table_keys
  @erb_path = erb_path_for("admin_show")
end