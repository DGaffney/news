require_relative 'tweet'

class Provider::Twitter::User
  def self.generate(person)
    flat_person = person.dup
    flat_person.delete("status")
    user = Provider::Twitter::User.new(flat_person)
    tweet = Provider::Twitter::Tweet.new(person["status"])
    user.twitter_id = flat_person["id"]
    if person["status"]
      tweet.twitter_id = person["status"]["id"] 
      person["status"]["entities"].each_pair do |entity_type, entities|
        if entity_type == "urls"
          entity = Provider::Twitter::Url.new(entity)
          entity.tweet_id = tweet.twitter_id
          tweet.entities << entity
        elsif entity_type == "hashtags"
          entity = Provider::Twitter::Hashtag.new(entity)
          entity.tweet_id = tweet.twitter_id
          tweet.entities << entity
        elsif entity_type == "user_mentions"
          entity = Provider::Twitter::Url.new(entity)
          entity.tweet_id = tweet.twitter_id
          tweet.entities << entity
        end
      end
    end
    user.tweets << tweet
    user
  end

  include MongoMapper::Document
  key :twitter_id, Integer, :required => true
  key :twitter_id_str, String
  key :name, String, :required => true
  key :screen_name, String, :required => true
  key :location, String
  key :url, String
  key :description, String
  key :protected, Boolean, :default => false, :required => true
  key :followers_count, Integer, :default => 0, :required => true
  key :friends_count, Integer, :default => 0, :required => true
  key :listed_count, Integer, :default => 0, :required => true
  key :created_at, Time, :required => true
  key :favourites_count, Integer
  key :utc_offset, Integer
  key :time_zone, String
  key :geo_enabled, Boolean, :default => false, :required => true
  key :verified, Boolean, :default => false, :required => true
  key :statuses_count, Integer, :default => 0, :required => true
  key :lang, String
  key :contributors_enabled, Boolean, :default => false, :required => true
  key :is_translator, Boolean, :default => false, :required => true
  key :profile_background_color, String, :default => "C0DEED", :required => true
  key :profile_background_image_url, String
  key :profile_background_image_url_https, String
  key :profile_background_tile, Boolean, :default => false, :required => true
  key :profile_image_url, String
  key :profile_image_url_https, String
  key :profile_link_color, String, :default => "0084B4", :required => true
  key :profile_sidebar_border_color, String, :default => "C0DEED", :required => true
  key :profile_sidebar_fill_color, String, :default => "DDEEF6", :required => true
  key :profile_text_color, String, :default => "333333", :required => true
  key :profile_use_background_image, Boolean, :default => true, :required => true
  key :default_profile, Boolean, :default => false, :required => true
  key :default_profile_image, Boolean, :default => false, :required => true
  key :following, Boolean, :default => false, :required => true
  key :follow_request_sent, Boolean, :default => false, :required => true
  key :notifications, Boolean, :default => false, :required => true
  key :account_snapshot_id, ObjectId
  many :tweets, :through => Provider::Twitter::Tweet, :class_name => "Provider::Twitter::Tweet"
  belongs_to :account_snapshot
  
  def self.example
    {"created_at"=>"Sat Dec 01 11:01:18 +0000 2012", "id"=>274830526970474496, "id_str"=>"274830526970474496", "text"=>"Getting ready for the #kingsofcode hack battle in Amsterdam! Just got off the plane, running on 2hrs sleep, so will see how this goes!", "source"=>"<a href=\"http://twitter.com/download/iphone\" rel=\"nofollow\">Twitter for iPhone</a>", "truncated"=>false, "in_reply_to_status_id"=>nil, "in_reply_to_status_id_str"=>nil, "in_reply_to_user_id"=>nil, "in_reply_to_user_id_str"=>nil, "in_reply_to_screen_name"=>nil, "user"=>{"id"=>14447132, "id_str"=>"14447132", "name"=>"Aaron Parecki", "screen_name"=>"aaronpk", "location"=>"Portland, OR", "url"=>"http://aaronparecki.com/", "description"=>"CTO of @esri R&D Center, Portland. Creating my own reality.", "protected"=>false, "followers_count"=>1776, "friends_count"=>619, "listed_count"=>200, "created_at"=>"Sat Apr 19 22:38:15 +0000 2008", "favourites_count"=>1543, "utc_offset"=>-28800, "time_zone"=>"Pacific Time (US & Canada)", "geo_enabled"=>true, "verified"=>false, "statuses_count"=>4331, "lang"=>"en", "contributors_enabled"=>false, "is_translator"=>false, "profile_background_color"=>"7A9AAF", "profile_background_image_url"=>"http://a0.twimg.com/profile_background_images/185835062/4786064324_b7049fbec8_b.jpg", "profile_background_image_url_https"=>"https://si0.twimg.com/profile_background_images/185835062/4786064324_b7049fbec8_b.jpg", "profile_background_tile"=>true, "profile_image_url"=>"http://a0.twimg.com/profile_images/1767475493/aaronpk-glasses_normal.png", "profile_image_url_https"=>"https://si0.twimg.com/profile_images/1767475493/aaronpk-glasses_normal.png", "profile_link_color"=>"0000FF", "profile_sidebar_border_color"=>"87BC44", "profile_sidebar_fill_color"=>"94C8FF", "profile_text_color"=>"000000", "profile_use_background_image"=>true, "default_profile"=>false, "default_profile_image"=>false, "following"=>true, "follow_request_sent"=>false, "notifications"=>nil}, "geo"=>{"type"=>"Point", "coordinates"=>[52.37051453, 4.8930892]}, "coordinates"=>{"type"=>"Point", "coordinates"=>[4.8930892, 52.37051453]}, "place"=>{"id"=>"99cdab25eddd6bce", "url"=>"http://api.twitter.com/1/geo/id/99cdab25eddd6bce.json", "place_type"=>"city", "name"=>"Amsterdam", "full_name"=>"Amsterdam, North Holland", "country_code"=>"NL", "country"=>"The Netherlands", "bounding_box"=>{"type"=>"Polygon", "coordinates"=>[[[4.7289, 52.278227], [5.079207, 52.278227], [5.079207, 52.431229], [4.7289, 52.431229]]]}, "attributes"=>{}}, "contributors"=>nil, "retweet_count"=>0, "favorited"=>false, "retweeted"=>false}
  end
  
  def self.new_from_raw(user, account_snapshot_id)
    obj = self.new
    obj.account_snapshot_id                = account_snapshot_id
    obj.twitter_id                         = user["id"]
    obj.twitter_id_str                     = user["id_str"]
    obj.name                               = user["name"]
    obj.screen_name                        = user["screen_name"]
    obj.location                           = user["location"]
    obj.url                                = user["url"]
    obj.description                        = user["description"]
    obj.protected                          = user["protected"]
    obj.followers_count                    = user["followers_count"]
    obj.friends_count                      = user["friends_count"]
    obj.listed_count                       = user["listed_count"]
    obj.created_at                         = user["created_at"]
    obj.favourites_count                   = user["favourites_count"]
    obj.utc_offset                         = user["utc_offset"]
    obj.time_zone                          = user["time_zone"]
    obj.geo_enabled                        = user["geo_enabled"]
    obj.verified                           = user["verified"]
    obj.statuses_count                     = user["statuses_count"]
    obj.lang                               = user["lang"]
    obj.contributors_enabled               = user["contributors_enabled"]
    obj.is_translator                      = user["is_translator"]
    obj.profile_background_color           = user["profile_background_color"]
    obj.profile_background_image_url       = user["profile_background_image_url"]
    obj.profile_background_image_url_https = user["profile_background_image_url_https"]
    obj.profile_background_tile            = user["profile_background_tile"]
    obj.profile_image_url                  = user["profile_image_url"]
    obj.profile_image_url_https            = user["profile_image_url_https"]
    obj.profile_link_color                 = user["profile_link_color"]
    obj.profile_sidebar_border_color       = user["profile_sidebar_border_color"]
    obj.profile_sidebar_fill_color         = user["profile_sidebar_fill_color"]
    obj.profile_text_color                 = user["profile_text_color"]
    obj.profile_use_background_image       = user["profile_use_background_image"]
    obj.default_profile                    = user["default_profile"]
    obj.default_profile_image              = user["default_profile_image"]
    obj.following                          = user["following"]
    obj.follow_request_sent                = user["follow_request_sent"]
    obj.notifications                      = user["notifications"]
    if user["status"]
      tweet = Provider::Twitter::Tweet.new_from_raw(user["status"]) rescue nil
      obj.tweets << tweet unless tweet.nil?
    end
    if user["statuses"]
      user["statuses"].each do |status|
        tweet = Provider::Twitter::Tweet.new_from_raw(status) rescue nil
        obj.tweets << tweet unless tweet.nil?
      end
    end
    obj
  end

end
