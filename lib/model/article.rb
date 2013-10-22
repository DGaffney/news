class Article
  include NewYorkTimesTopicGenerator
  include GuardianTopicGenerator
  include MongoMapper::Document

  key :url, String
  key :title, String
  key :author_ids, Array
  key :content, String
  key :publisher_code, String
  key :published_at, Time
  one :new_york_times, :through => NewYorkTimesArticle, :class_name => "NewYorkTimesArticle"
  one :guardian, :through => GuardianArticle, :class_name => "GuardianArticle"
  one :npr, :through => NPRArticle, :class_name => "NPRArticle"
  one :atlantic_wire, :through => AtlanticWireArticle, :class_name => "AtlanticWireArticle"
  one :mother_jones, :through => MotherJonesArticle, :class_name => "MotherJonesArticle"
  one :huffington_post, :through => HuffingtonPostArticle, :class_name => "HuffingtonPostArticle"
  one :christian_science_monitor, :through => ChristianScienceMonitorArticle, :class_name => "ChristianScienceMonitorArticle"
  one :reuters, :through => ReutersArticle, :class_name => "ReutersArticle"
  many :authors, :in => :author_ids
  timestamps!
  
  scope :within_time_range,  lambda { |start_range, end_range| where(:created_at.gte => start_range, :created_at.lte => end_range) }
  
  def raw
    self.send(self.publisher_code)
  end
  
  def self.earliest_time_range
    Article.where(:published_at.ne => nil).order(:published_at).first.published_at.ymd
  end
  
  def self.latest_time_range
    Article.where(:published_at.ne => nil).order(:published_at).last.published_at.ymd
  end
end