class Score
  include MongoMapper::Document
  key :provenance, String
  key :url, String
  key :article_id, ObjectId
  key :value, Float
  key :ego_id, ObjectId
  key :article_created_at, Time
  timestamps!
  
  def self.a_priori_limit_offset(opts={})
    opts.limit||=45
    opts.offset||=0
    opts.start_range||=Time.parse(Article.earliest_time_range)
    opts.end_range||=Time.parse(Article.latest_time_range+" 23:59:59")
    self.where(:article_id.ne => nil, :ego_id => nil, :article_created_at.gte => opts.start_range, :article_created_at.lte => opts.end_range).order(:value.desc).fields(:article_id).limit(opts.limit).offset(opts.offset)
  end
end