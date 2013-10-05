module TwitterRequests
  def request_twitter(url, opts={})
    credentials = opts.delete(:credentials)
    @client = Twitter::Client.new(credentials)
    JSON.parse(@client.send(url, opts).to_json)
  end
end