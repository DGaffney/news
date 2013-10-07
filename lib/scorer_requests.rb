module ScorerRequests
  def request_shared_count(url, *unused)
    request = Setting.shared_count_url + "?url=" + url
    JSON.parse(RestClient.get(request))
  end
  
  def request_bitly(url, *unused)
    client = Bitly.new(Setting.bitly_user_name, Setting.bitly_api_key)
    client.shorten(url).stats
  end
end