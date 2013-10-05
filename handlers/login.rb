get "/login/:domain" do
  token, url = (params[:domain]+"_login").classify.constantize.prepare
  session[:request_token] = token
  redirect url
end

get "/callback/:domain" do
  account = Account.create_account_for(params[:domain], (params[:domain]+"_login").classify.constantize.get_credentials(params, session), current_ego.id)
  redirect request.referer
end

post "/callback/:domain" do
  binding.pry
  account = Account.create_account_for(params[:domain], (params[:domain]+"_login").classify.constantize.get_credentials(params, session), current_ego.id)
  redirect request.referer
end