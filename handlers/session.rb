get "/signup" do
  erb :"/session/signup"
end

post "/signup" do
  if Ego.first(:screen_name => params[:screen_name])
    flash[:error] = "Sorry, but someone else already has this account. Have you forgot your password?"
    redirect "/signup" 
  end
  if params[:password] != params[:check_password]
    flash[:error] = "Sorry, but you're passwords didn't match. Please try again!"
    redirect "/signup" 
  end
  password_salt = BCrypt::Engine.generate_salt
  password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)

  ego = Ego.new(:screen_name => params[:screen_name], :salt => password_salt, :hash => password_hash)
  ego.save!
  session[:ego_id] = ego.id.to_s
  redirect "/"
end
 
get "/login" do
  erb :"/session/login"
end
 
post "/login" do
  ego = Ego.first(:screen_name => params[:screen_name])
  if ego
    if ego.hash == BCrypt::Engine.hash_secret(params[:password], ego.salt)
      session[:ego_id] = ego.id.to_s
      flash[:success] = "Logged in!"
      redirect "/"
    end
  end
  flash[:error] = "Couldn't authenticate you - please try again"
  redirect "/"
end
 
get "/logout" do
  session[:ego_id] = nil
  flash[:success] = "Logged out!"
  redirect "/"
end