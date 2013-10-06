module RandomColumn
  extend ActiveSupport::Concern
  included do
    key :_rand, Float, :default => rand
    before_save :set_rand_value
  end

  def set_rand_value
    self._rand = rand
  end
end
#MongoMapper.database.collection_names.collect{|m| m.classify.constantize.ensure_index(:_rand) rescue nil}
#Cache.ensure_index(:rand)
MongoMapper::Document.plugin(RandomColumn)