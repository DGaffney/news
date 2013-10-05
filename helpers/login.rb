module LoginHelper
  
  def logged_in?
    session[:ego_id] && !session[:ego_id].empty?
  end
  
  def current_ego
    Ego.find(session[:ego_id])
  end
  
  def login_for(domain)
    domain.classify.constantize.prepare
    domain.classify.constantize.url
  end
end