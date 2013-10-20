class NPRExternalAsset
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :type, String
  key :url, String
  key :o_embed, String
  key :external_id, String
  key :credit, String
  key :parameters, String
  key :caption, String

  def self.new_from_raw(external_asset)
    obj = self.new
    obj.npr_id = external_asset.id
    obj.type = external_asset.type
    obj.url = external_asset.url
    obj.o_embed = external_asset.oEmbed
    obj.external_id = external_asset.externalId
    obj.credit = external_asset.credit
    obj.parameters = external_asset.parameters
    obj.caption = external_asset.caption
    obj
  end
end