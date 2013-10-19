module TwitterRequests
  def request_twitter(url, opts={})
    credentials = opts.delete(:credentials)
    @client = Twitter::Client.new
    credentials.each do |key, value|
      @client.send(key+"=", value)
    end
    case url
    when "friend_ids"
      return @client.send(url, opts).attrs
    when "follower_ids"
      return @client.send(url, opts).attrs
    else
      return JSON.parse(@client.send(url, opts).to_json)
    end
  end
end