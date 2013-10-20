class NPRMember
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :title, String
  def self.new_from_raw(member)
    obj = self.new
    obj.npr_id = member.id
    obj.title = member.title.to_s
    obj
  end
end