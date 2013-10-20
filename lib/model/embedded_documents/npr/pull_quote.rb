class NPRPullQuote
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :text, String
  key :person, String
  key :date
  
  def self.new_from_raw(pull_quote)
    obj = self.new
    obj.npr_id = pull_quote.id
    obj.text = pull_quote.text
    obj.person = pull_quote.person
    obj.date = pull_quote.date
    obj
  end
end
