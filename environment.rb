require 'mongo_mapper'
require 'resque'
MongoMapper.connection = Mongo::MongoClient.new("localhost", 27017, :pool_size => 25, :pool_timeout => 60)
MongoMapper.database = "news"