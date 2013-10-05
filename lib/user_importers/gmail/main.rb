require 'net/imap'
require 'gmail_xoauth'
require 'oauth2'
require 'mail'

class Importer
end
class Importer::GMail
  attr_accessor :gmail
  
  def oauth_client
    OAuth2::Client.new(Setting.google_client_id, Setting.google_client_secret, {
                  :site => 'https://accounts.google.com', 
                  :authorize_url => "/o/oauth2/auth", 
                  :token_url => "/o/oauth2/token"
                })
  end
  
  def refreshed_client(credentials)
    refresh_access_token_obj = OAuth2::AccessToken.new(self.oauth_client, credentials["access_token"], {refresh_token: credentials["refresh_token"]})
    refresh_access_token_obj.refresh!
  end

  def initialize(credentials)
    #will probably just want to pass in an acct here... for all cases...
    @gmail = refreshed_client(credentials)
  end
  
  def example
    email = @gmail.get('https://www.googleapis.com/userinfo/email?alt=json').parsed["data"]["email"]
    imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)
    imap.authenticate('XOAUTH2', @email["data"]["email"], @gmail.token)
    imap.select('INBOX')
    message_id = 10000
    imap.search(['ALL']).each do |message_id|

        msg = imap.fetch(message_id,'RFC822')[0].attr['RFC822']
        mail = Mail.read_from_string msg

        puts mail.subject
        puts mail.text_part.body.to_s
        puts mail.html_part.body.to_s

    end
    
  end
end
credentials = Account.all.last.credentials
gz = Importer::GMail.new(credentials)
@gmail = gz.gmail
message_id = 100
email = @gmail.get('https://www.googleapis.com/userinfo/email?alt=json').parsed["data"]["email"]
imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)
imap.authenticate('XOAUTH2', email, @gmail.token)
imap.select('INBOX')
msg = imap.fetch(message_id,'RFC822')[0].attr['RFC822']
mail = Mail.read_from_string msg
