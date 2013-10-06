class RankURL
  include Sidekiq::Worker
  def perform(url)
    SharedCountScorer.score(url)
    BitlyScorer.score(url)
    RankURL.perform_in(15.minutes, url)
  end
end