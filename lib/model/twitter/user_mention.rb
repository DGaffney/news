class Provider::Twitter::UserMention
  include MongoMapper::EmbeddedDocument
  key :screen_name, String
  key :name, String
  key :twitter_id, Integer
  key :twitter_id_str, String
  key :indices, Array
  belongs_to :tweet
  
  def self.example
    {"name"=>"film.culture360", "id_str"=>"211760188", "id"=>211760188, "indices"=>[3, 19], "screen_name"=>"film_culture360"}
  end

  def self.new_from_raw(entity)
    obj                = self.new
    obj.screen_name    = entity["screen_name"]
    obj.name           = entity["name"]
    obj.twitter_id     = entity["id"]
    obj.twitter_id_str = entity["id_str"]
    obj.indices        = entity["indices"]
    obj
  rescue
    example
  end
  
end
