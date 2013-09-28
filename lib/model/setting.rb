class Setting
  include MongoMapper::Document
  key :name, String, :required => true
  key :value
  
  def self.method_missing(method, *args)
    return set_value(method.to_s.chop, args.first) if method.to_s.strip.last == "="
    if setting = Setting.first(:name => method.to_s)
      return setting.value
    else
      super
    end
  end
  
  def self.set_value(method, args)
    setting = self.first_or_create(:name => method.to_s)
    setting.value = args
    setting.save!
  end
end