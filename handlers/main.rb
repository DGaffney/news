get "/" do
  redirect "/news"
end

get "/news" do
  erb :index, :locals => @locals
end

get "/news.json" do
  @locals.to_json
end