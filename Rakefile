load 'environment.rb'
require 'resque/tasks' 

desc "Set up core DB settings"
task :seeds do
  Setting.shared_count_url = "http://api.sharedcount.com/"
  Setting.nytimes_newswire_api_key = "2c708e7af0c925595b9d3a2132b89070:5:64461877"
  Setting.bitly_user_name = "dgaff"
  Setting.bitly_api_key = "R_9ceb018f79a8cc844347246db9e123c0"
  Setting.google_api_key = "AIzaSyAMRl3Y7p9M-tFarmnXnyVQwnnYfqLJIg8"
  Setting.google_client_id = "646738893306-b5lcuba1qm847tju53d52mt3fhiqgd9v.apps.googleusercontent.com"
  Setting.google_client_secret = "RsCXPfDBOeKcln9N6_C6RzRc"
  Setting.twitter_consumer_key = "13731562-GEULCwcI0kISER1y7kx4z5DCTvYuhFLtInn2ROOLG"
  Setting.twitter_consumer_secret = "H88Fy065246C6XdydrwFf2unHHIVAGjPFxoZdJx3c"
  Setting.facebook_app_id = "558094644251461"
  Setting.facebook_app_secret = "d23dfa36da5553138fa6d50f7a1b1288"
end
