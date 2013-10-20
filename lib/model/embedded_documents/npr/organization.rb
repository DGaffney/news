#<NPR::Entity::Organization:0x007fc534fb9ab8 @name="NPR", @website="http://www.npr.org/", @orgId=1, @orgAbbr="NPR">
class NPROrganization
  include MongoMapper::EmbeddedDocument
  key :name, String
  key :website, String
  key :org_id, Integer
  key :org_abbr, String
  def self.new_from_raw(organization)
    obj = self.new
    obj.name = organization.name
    obj.website = organization.website
    obj.org_id = organization.orgId
    obj.org_abbr = organization.orgAbbr
    obj
  end
end