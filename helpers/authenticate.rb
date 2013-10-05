module AuthenticateHelper
  #placeholder for authentication in the future.
  def authenticate_for(user, environment={})
    environment[:methods] ||= ["get", "post"]
    environment[:path] ||= "/"
    environment[:params] ||= {}
    return true
  end
end
