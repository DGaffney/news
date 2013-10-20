require_relative 'permission'
require_relative 'format'
class NPRAudio
  include MongoMapper::EmbeddedDocument
  key :npr_id, Integer
  key :stream, Boolean
  key :title, String
  key :duration, Integer
  key :description, String
  key :rights_holder, String
  one :permission, :through => NPRPermission, :class_name => "NPRPermission"
  one :format, :through => NPRFormat, :class_name => "NPRFormat"
  def self.new_from_raw(audio)
    obj = self.new
    obj.npr_id = audio.id
    obj.stream = audio.stream
    obj.title = audio.title
    obj.duration = audio.duration
    obj.description = audio.description
    obj.rights_holder = audio.rightsHolder
    obj.permission = NPRPermission.new_from_raw(audio.permissions)
    obj.format = NPRFormat.new_from_raw(audio.formats)
    obj
  end
end