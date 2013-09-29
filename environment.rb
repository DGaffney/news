require 'mongo_mapper'
require 'rest-client'
require 'hashie'
require 'json'
require 'resque'
require 'pry'
require 'sinatra'

MongoMapper.connection = Mongo::MongoClient.new("localhost", 27017, :pool_size => 25, :pool_timeout => 60)
MongoMapper.database = "news"

Dir[File.dirname(__FILE__) + '/extensions/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/helpers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/handlers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/before_hooks/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/article_processors/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/crawlers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/scorers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/model/embedded_documents/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/model/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/resque_tasks/*.rb'].each {|file| require file }


set :erb, :layout => :'layouts/main'
enable :sessions

helpers LayoutHelper, ParamsHelper