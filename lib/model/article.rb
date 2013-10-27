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
  one :bbc_news, :through => BBCNewsArticle, :class_name => "BBCNewsArticle"
  one :washington_post, :through => WashingtonPostArticle, :class_name => "WashingtonPostArticle"
  one :salon, :through => SalonArticle, :class_name => "SalonArticle"
  one :wall_street_journal, :through => WallStreetJournalArticle, :class_name => "WallStreetJournalArticle"
  one :politico, :through => PoliticoArticle, :class_name => "PoliticoArticle"
  one :economist, :through => EconomistArticle, :class_name => "EconomistArticle"
  one :slate, :through => SlateArticle, :class_name => "SlateArticle"
  one :foreign_affairs, :through => ForeignAffairsArticle, :class_name => "ForeignAffairsArticle"
  one :new_yorker, :through => NewYorkerArticle, :class_name => "NewYorkerArticle"
  many :authors, :in => :author_ids
  timestamps!
  
  scope :within_time_range,  lambda { |start_range, end_range| where(:created_at.gte => start_range, :created_at.lte => end_range) }
  scope :by_publisher_code,  lambda { |publisher_code| where(:publisher_code => publisher_code) }
  def raw
    self.send(self.publisher_code)
  end
  
  def self.earliest_time_range
    Article.where(:published_at.ne => nil).order(:published_at).first.published_at.ymd
  end
  
  def self.latest_time_range
    Article.where(:published_at.ne => nil).order(:published_at).last.published_at.ymd
  end
  
  def track_url(current_ego)
    "/articles/#{self.id}/#{current_ego.id rescue "none"}"
  end

  def categories
    return self.raw.respond_to?(:categories) ? self.cleaned_categories : []
  end
  
  def cleaned_categories
    if self.raw.categories.empty?
      return []
    elsif self.raw.categories.class == String
      return self.raw.categories.split(",")
    end
    return self.raw.categories-self.junk_categories
  end

  def junk_categories
    (self.raw.respond_to?(:junk_categories) ? self.raw.junk_categories : [])|[""]
  end

  def key_terms
    self.title.remove_stopwords.split(/\W/).reject{|s| s.length < 3}
  end
end