before do
  set_content_type :json if request.path.include?(".json")
  Sinatra::Base.set :erb, :layout => :'/layouts/main'
end
