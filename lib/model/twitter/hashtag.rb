class Provider::Twitter::Hashtag
  include MongoMapper::EmbeddedDocument
  key :text, String
  key :indices, Array
  belongs_to :tweet
  
  def self.example
    {"text"=>"IDMA", "indices"=>[27, 32]}
  end
  
  def self.new_from_raw(entity)
    return if entity.nil?
    obj         = self.new
    obj.text    = entity["text"]
    obj.indices = entity["indices"]
    obj
  end
end