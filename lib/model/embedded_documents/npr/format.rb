class NPRFormat
  include MongoMapper::EmbeddedDocument
  key :wm, String
  key :mediastream, String
  key :mp3s, Array

  def self.new_from_raw(format)
    obj = self.new
    obj.wm = format.wm
    obj.mediastream = format.mediastream
    obj.mp3s = format.mp3s.collect(&:to_s)
    obj
  end
end