require 'koala'
class FacebookLogin

  def self.oauth_client(redirect_url="http://#{Setting.host}/callback/facebook")
    Koala::Facebook::OAuth.new(Setting.facebook_app_id, Setting.facebook_app_secret, redirect_url)
  end

  def self.prepare
    @oauth = self.oauth_client
    return [nil, @oauth.url_for_oauth_code]
  end
  
  def self.get_credentials(params, session)
    @oauth = self.oauth_client
    oauth_access_token = @oauth.get_access_token(params[:code])
    @graph = Koala::Facebook::API.new(oauth_access_token)
    profile = @graph.get_object("me")
    return {:oauth_access_token => oauth_access_token, :acct_alias => profile["username"]||profile["id"], :print_alias => profile["name"]}
  end
end