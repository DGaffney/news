class Provider::Twitter::Relationship
  include MongoMapper::Document
  key :direction, String
  key :account_id, ObjectId
  key :ids, Array
  key :next_cursor, Integer
  key :next_cursor_str, String
  key :previous_cursor, Integer
  key :previous_cursor_str, String
  belongs_to :account
  
  def self.example
    {
                      "ids" => [1270746139, 27252380, 1650712873, 28357827, 11766632, 1318037712], 
              "next_cursor" =>  0, 
          "next_cursor_str" => "0", 
          "previous_cursor" =>  0, 
      "previous_cursor_str" => "0"
    }
  end

  def self.new_from_raw(ids, account_id, direction)
    obj = self.new
    obj.direction           = direction
    obj.account_id          = account_id
    obj.ids                 = ids.ids
    obj.next_cursor         = ids.next_cursor
    obj.next_cursor_str     = ids.next_cursor_str
    obj.previous_cursor     = ids.previous_cursor
    obj.previous_cursor_str = ids.previous_cursor_str
    obj
  end
  
  def self.ids_for(direction, account_id)
    self.where(direction: direction, account_id: account_id).fields(:ids).collect(&:ids).flatten
  end
  
end
