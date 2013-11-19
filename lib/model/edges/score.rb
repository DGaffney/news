class Score
  include MongoMapper::Document
  key :provenance, String
  key :url, String
  key :article_id, ObjectId
  key :value, Float
  key :ego_id, ObjectId
  key :article_created_at, Time
  key :article_terms, Array
  belongs_to :article
  belongs_to :ego
  timestamps!

  def self.scores_for_ego(ego, params)
    where = {:article_created_at.gte => params.start_range, 
    :article_created_at.lte => params.end_range, 
    :ego_id => ego.id, 
    :provenance => "personal_score"}
    where.article_terms = params.query.split(" ").collect{|term| /.*(,| |^)#{Regexp.escape(term)}.*/i} if params.query && !params.query.empty?
    Score.fields(
    :article_id, 
    :value
    ).where(
      where
    ).sort(
      :score.desc
    ).paginate(
      :per_page => params.per_page,
      :page => params.page
    ).collect{|s| 
      [s.article_id, s.value]
    }.sort_by{|k,v| v}.reverse
  end
  
  def self.scores_for_popularity(params)
    where = {:article_created_at.gte => params.start_range,
    :article_created_at.lte => params.end_range,
    :ego_id => nil, 
    :provenance => "score_url"}
    where.article_terms = params.query.split(" ").collect{|term| /.*(,| |^)#{Regexp.escape(term)}.*/i} if params.query && !params.query.empty?
    Score.fields(
    :article_id,
    :value
    ).where(
      where
    ).sort(
      :score.desc
    ).paginate(
      :per_page => params.per_page,
      :page => params.page
    ).collect{|s| 
      [s.article_id, s.value]
    }.sort_by{|k,v| v}.reverse
  end
end