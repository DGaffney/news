class Ego
  include MongoMapper::Document
  key :account_ids, Array
  key :salt, String
  key :hash, String
  key :screen_name, String
  timestamps!
  has_many :accounts, :in => :account_ids
  
  def self.admin_table_keys
    [:account_ids, :screen_name, :created_at, :updated_at]
  end
  
  def accounts_for(domain, page=nil, per_page=nil)
    if page && per_page
      return Account.where(:ego_id => self.id, :domain => domain).paginate(:page => page, :per_page => per_page)
    else
      return Account.all(:ego_id => self.id, :domain => domain)
    end
  end
end