module TwitterRequests
  def request_twitter(url, opts={})
    credentials = opts.delete(:credentials)
    @client = Twitter::Client.new
    credentials.each do |key, value|
      @client.send(key+"=", value)
    end
    JSON.parse(@client.send(url, opts).to_json)
  end
end