class SharedCount < Scorer

  def self.score(url)
    # return some score of some sort, save into an object of some nature...
    request = Setting.shared_count_url + "?url=" + url
    return Cache.get(request)
  end
end