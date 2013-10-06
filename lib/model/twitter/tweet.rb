require_relative 'user_mention'
require_relative 'coordinate'
require_relative 'hashtag'
require_relative 'media'
require_relative 'place'
require_relative 'geo'
require_relative 'url'

class Provider::Twitter::Tweet
  include MongoMapper::Document
  key :created_at, Time, :required => true
  key :twitter_id, Integer, :required => true
  key :twitter_id_str, String, :required => true
  key :text, String, :required => true
  key :source, String, :required => true
  key :truncated, Boolean, :default => false, :required => true
  key :in_reply_to_status_id, Integer
  key :in_reply_to_status_id_str, String
  key :in_reply_to_user_id, Integer
  key :in_reply_to_user_id_str, String
  key :in_reply_to_screen_name, String
  key :contributors, Array, :default => []
  key :retweet_count, Integer, :default => 0, :required => true
  key :favorited, Boolean, :default => false, :required => true
  key :retweeted, Boolean, :default => false, :required => true
  key :possibly_sensitive, Boolean, :default => false, :required => true
  one :geo, :through => Provider::Twitter::Geo, :class_name => "Provider::Twitter::Geo"
  one :coordinate, :through => Provider::Twitter::Coordinate, :class_name => "Provider::Twitter::Coordinate"
  one :place, :through => Provider::Twitter::Place, :class_name => "Provider::Twitter::Place"
  many :hashtags, :through => Provider::Twitter::Hashtag, :class_name => "Provider::Twitter::Hashtag"
  many :urls, :through => Provider::Twitter::Url, :class_name => "Provider::Twitter::Url"
  many :user_mentions, :through => Provider::Twitter::UserMention, :class_name => "Provider::Twitter::UserMention"
  many :media, :through => Provider::Twitter::Media, :class_name => "Provider::Twitter::Media"
  key :account_id, ObjectId
  belongs_to :user

  def self.example
    {"entities"=>{"user_mentions"=>[], "urls"=>[{"display_url"=>"tehelka.com/story_main54.a...", "expanded_url"=>"http://www.tehelka.com/story_main54.asp?filename=Ws041212SPORTS.asp", "url"=>"http://t.co/uZmKgdkO", "indices"=>[120, 140]}], "hashtags"=>[]}, "text"=>"On the day Indian Olympics Association was suspended by IOC, Rahul Mehra says the move gives an opportunity to clean up http://t.co/uZmKgdkO", "retweet_count"=>2, "coordinates"=>nil, "possibly_sensitive"=>false, "in_reply_to_status_id_str"=>nil, "contributors"=>nil, "in_reply_to_user_id_str"=>nil, "id_str"=>"276035961274638336", "in_reply_to_screen_name"=>nil, "retweeted"=>false, "truncated"=>false, "created_at"=>"Tue Dec 04 18:51:16 +0000 2012", "geo"=>nil, "place"=>nil, "in_reply_to_status_id"=>nil, "favorited"=>false, "source"=>"web", "id"=>276035961274638336, "in_reply_to_user_id"=>nil}
  end

  def self.new_from_raw(tweet)
    return if tweet.nil?
    obj = self.new
    obj.created_at                = tweet["created_at"]
    obj.twitter_id                = tweet["id"]
    obj.twitter_id_str            = tweet["id_str"]
    obj.text                      = tweet["text"]
    obj.source                    = tweet["source"]
    obj.truncated                 = tweet["truncated"]
    obj.in_reply_to_status_id     = tweet["in_reply_to_status_id"]
    obj.in_reply_to_status_id_str = tweet["in_reply_to_status_id_str"]
    obj.in_reply_to_user_id       = tweet["in_reply_to_user_id"]
    obj.in_reply_to_user_id_str   = tweet["in_reply_to_user_id_str"]
    obj.in_reply_to_screen_name   = tweet["in_reply_to_screen_name"]
    obj.contributors              = tweet["contributors"]
    obj.retweet_count             = tweet["retweet_count"]
    obj.favorited                 = tweet["favorited"]
    obj.retweeted                 = tweet["retweeted"]
    obj.possibly_sensitive        = tweet["possibly_sensitive"]
    if tweet["entities"]
      tweet["entities"].each_pair do |entity_type, entities|
        if entity_type == "media"
          entities.each do |entity|
            entity = Provider::Twitter::Media.new_from_raw(entity)
            obj.media << entity
          end
        elsif entity_type == "urls"
          entities.each do |entity|
            entity = Provider::Twitter::Url.new_from_raw(entity)
            obj.urls << entity
          end
        elsif entity_type == "hashtags"
          entities.each do |entity|
            entity = Provider::Twitter::Hashtag.new_from_raw(entity)
            obj.hashtags << entity
          end
        elsif entity_type == "user_mentions"
          entities.each do |entity|
            entity = Provider::Twitter::UserMention.new_from_raw(entity)
            obj.user_mentions << entity rescue return
          end
        end
      end
    end
    place = Provider::Twitter::Place.new_from_raw(tweet["place"])
    if place
      obj.place = place
    end
    geo = Provider::Twitter::Geo.new_from_raw(tweet["geo"])
    if geo
      obj.geo = geo
    end
    coordinate = Provider::Twitter::Coordinate.new_from_raw(tweet["coordinate"])
    if coordinate
      obj.coordinate = coordinate
    end
    obj
  end  

rescue 
  return
  
end
