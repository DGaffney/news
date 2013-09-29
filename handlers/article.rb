get "/news" do
  erb :"articles/index", :layout => :"layouts/main", :locals => {:html_page_title => "The News", :page_title => "The News"}
end

get "/news.json" do
  {:articles => @articles, :page => @page, :next => @next, :previous => @previous}.to_json
end