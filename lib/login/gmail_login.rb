require 'net/imap'
require 'gmail_xoauth'
require 'oauth2'
class GmailLogin
  def self.oauth_client
    OAuth2::Client.new(Setting.google_client_id, Setting.google_client_secret, {
                  :site => 'https://accounts.google.com', 
                  :authorize_url => "/o/oauth2/auth", 
                  :token_url => "/o/oauth2/token"
                })
  end

  def self.prepare
    scope = "https://mail.google.com/ https://www.google.com/analytics/feeds/ https://sites.google.com/feeds/ http://www.blogger.com/feeds/ http://www.google.com/books/feeds/ https://www.google.com/calendar/feeds/ https://www.google.com/m8/feeds/ https://www.googleapis.com/auth/structuredcontent https://docs.google.com/feeds/ http://finance.google.com/finance/feeds/ https://mail.google.com/mail/feed/atom/ https://www.googleapis.com/auth/userinfo.email http://maps.google.com/maps/feeds/ http://picasaweb.google.com/data/ http://www-opensocial.googleusercontent.com/api/people http://www.google.com/sidewiki/feeds/ https://spreadsheets.google.com/feeds/ http://www.google.com/webmasters/tools/feeds/ http://gdata.youtube.com"
    @oauth = self.oauth_client
    return [nil, @oauth.auth_code.authorize_url(:redirect_uri => "http://#{Setting.host}/callback/gmail", :scope => scope, :access_type => "offline", :approval_prompt => 'force')]
  end
  
  def self.get_credentials(params, session)
    access_token = self.oauth_client.auth_code.get_token(params[:code], :redirect_uri => "http://#{Setting.host}/callback/gmail")
    session[:access_token] = access_token.token
    @message = "Successfully authenticated with the server"
    @access_token = session[:access_token]
    @email = access_token.get('https://www.googleapis.com/userinfo/email?alt=json').parsed
    return {:access_token => access_token.token, :refresh_token => access_token.refresh_token, :acct_alias => @email["data"]["email"], :print_alias => @email["data"]["email"]}
  end
end