class NPRPermission
  include MongoMapper::EmbeddedDocument
  key :download, Boolean
  key :stream, Boolean
  key :embed, Boolean

  def self.new_from_raw(permission)
    obj = self.new
    obj.download = permission.download
    obj.stream = permission.stream
    obj.embed = permission.embed
    obj
  end
end