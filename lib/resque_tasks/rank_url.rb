class RankURL
  include Sidekiq::Worker
  def perform(url)
    
    RankURL.perform_in(1.day, url)
  end
end