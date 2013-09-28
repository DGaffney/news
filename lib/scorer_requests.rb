module ScorerRequests
  def request_shared_count(url)
    request = Setting.shared_count_url + "?url=" + url
    RestClient.get(url)
  end
  
  def request_bitly(url)
    client = Bitly.new(Setting.bitly_user_name, Setting.bitly_api_key)
    client.shorten(url).stats
  end
end