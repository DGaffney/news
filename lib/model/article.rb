class Article
  include MongoMapper::Document
  key :url, String
  key :title, String
  key :author_ids, Array
  key :content, String
  key :publisher_code, String
  one :new_york_times, :through => NewYorkTimesArticle, :class_name => "NewYorkTimesArticle"
  many :authors, :in => :author_ids
  timestamps!
  
  def raw
    self.send(self.publisher_code)
  end
  
  def self.earliest_time_range
    Article.order(:created_at).first.created_at.strftime("%Y-%m-%d")
  end
  
  def self.latest_time_range
    Article.order(:created_at).last.created_at.strftime("%Y-%m-%d")
  end
end