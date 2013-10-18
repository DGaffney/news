get "/settings" do
  erb :"/ego/settings"
end

get "/change_password" do
  erb :"/ego/change_password"
end

post "/change_password" do
  ego = Ego.first(:screen_name => params[:screen_name])
  if ego && current_ego == ego
    if params[:password] == params[:check_password]
      password_salt = BCrypt::Engine.generate_salt
      password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
      ego.salt = password_salt
      ego.hash = password_hash
      ego.save!
      flash[:success] = "Logged in!"
    else 
      flash[:error] = "Sorry, but your passwords didn't match."
    end
  else
    flash[:error] = "Sorry, but you have to be logged in as that user to do that."
  end
  redirect request.referer
end