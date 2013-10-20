class NPRShow
  include MongoMapper::EmbeddedDocument
  key :show_date, Time
  key :seg_num, Integer
  key :program, String
  
  def self.new_from_raw(show)
    obj = self.new
    obj.show_date = show.showDate
    obj.seg_num = show.segNum
    obj.program = show.program
    obj
  end
end