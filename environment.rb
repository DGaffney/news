require 'mongo_mapper'
require 'rest-client'
require 'json'
require 'resque'
require 'pry'
require 'sinatra'
require 'bcrypt'
require 'sinatra/flash'
require 'sidekiq'
require 'sidekiq/web'
require 'feedzirra'

MongoMapper.connection = Mongo::MongoClient.new("ec2-54-224-26-29.compute-1.amazonaws.com", 27017, :pool_size => 25, :pool_timeout => 60)

# MongoMapper.connection = Mongo::MongoClient.new("localhost", 27017, :pool_size => 25, :pool_timeout => 60)
MongoMapper.database = "news"

class Provider
end

class Provider::Twitter
end

Dir[File.dirname(__FILE__) + '/extensions/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/plugins/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/helpers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/handlers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/before_hooks/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/requests/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/article_processors/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/crawlers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/scorers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/topic_generators/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/model/embedded_documents/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/model/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/model/edges/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/model/twitter/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/login/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/sidekiq_tasks/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/user_importers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/user_importers/**/*.rb'].each {|file| require file }


set :erb, :layout => :'layouts/main'
enable :sessions

helpers LayoutHelper, ParamsHelper, LoginHelper, AuthenticateHelper
CRAWLERS = [NewYorkTimesCrawl, GuardianCrawl, NPRCrawl, AtlanticWireCrawl, HuffingtonPostCrawl, MotherJonesCrawl, ChristianScienceMonitorCrawl, ReutersCrawl, BBCNewsCrawl, WashingtonPostCrawl, SalonCrawl, WallStreetJournalCrawl, PoliticoCrawl]

