class NPRTranscript
  include MongoMapper::EmbeddedDocument
  key :link, String
  def self.new_from_raw(transcript)
    obj = self.new
    obj.link = transcript.link.to_s
    obj
  end
end