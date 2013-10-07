get "/" do
  redirect "/news"
end
get "/.json" do
  redirect "/news.json"
end

get "/news" do
  erb :index, :locals => @locals
end

get "/news.json" do
  @locals.to_json
end

post "/news" do
  erb :index, :locals => @locals
end

post "/news.json" do
  
end