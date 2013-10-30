get "/articles/:id/:user_id" do
  binding.pry
  TrackURL.perform_async(params[:id], params[:user_id])
  article = Article.find(params[:id])
  redirect article.url
end