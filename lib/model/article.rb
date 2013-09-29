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
end