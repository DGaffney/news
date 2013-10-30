load 'environment.rb'

desc "Set up core DB settings"
task :seeds do
  Setting.shared_count_url = "http://api.sharedcount.com/"
  Setting.nytimes_newswire_api_key = "2c708e7af0c925595b9d3a2132b89070:5:64461877"
  Setting.guardian_content_api_key = "qxusnk94qsxsuzepdqxgpkxh"
  Setting.bitly_user_name = "dgaff"
  Setting.bitly_api_key = "R_9ceb018f79a8cc844347246db9e123c0"
  Setting.google_api_key = "AIzaSyAMRl3Y7p9M-tFarmnXnyVQwnnYfqLJIg8"
  Setting.google_client_id = "646738893306-b5lcuba1qm847tju53d52mt3fhiqgd9v.apps.googleusercontent.com"
  Setting.google_client_secret = "RsCXPfDBOeKcln9N6_C6RzRc"
  Setting.twitter_consumer_key = "kWDbUyUwIwyYyYdVCShd9Q"
  Setting.twitter_consumer_secret = "XswMmYIF1fu2nXnWhgHXq9STYlLKelGDvnWSJ76uzI"
  Setting.facebook_app_id = "558094644251461"
  Setting.facebook_app_secret = "d23dfa36da5553138fa6d50f7a1b1288"
  Setting.npr_api_key = "MDEyNDI3MzE2MDEzODIxNTA0NDM5NjAyZA001"
  Setting.npr_paginate_value = 10
  Setting.guardian_content_api_key = "qxusnk94qsxsuzepdqxgpkxh"
  Setting.atlantic_wire_feed_url = "http://feeds.feedburner.com/TheAtlanticWire?format=xml"
  Setting.huffington_post_feed_url = "http://feeds.huffingtonpost.com/huffingtonpost/raw_feed"
  Setting.mother_jones_feed_url = "http://feeds.feedburner.com/motherjones/BlogsAndArticles"
  Setting.christian_science_monitor_feed_url = "http://rss.csmonitor.com/feeds/csm"
  Setting.reuters_feed_url = "http://feeds.reuters.com/reuters/topNews"
  Setting.bbc_news_feed_url = "http://feeds.bbci.co.uk/news/rss.xml"
  Setting.washington_post_feed_urls = ["http://feeds.washingtonpost.com/rss/politics", "http://feeds.washingtonpost.com/rss/opinions", "http://feeds.washingtonpost.com/rss/sports", "http://feeds.washingtonpost.com/rss/national", "http://feeds.washingtonpost.com/rss/world", "http://feeds.washingtonpost.com/rss/business", "http://feeds.washingtonpost.com/rss/business/technology", "http://feeds.washingtonpost.com/rss/lifestyle", "http://feeds.washingtonpost.com/rss/entertainment"]
  Setting.salon_feed_url = "http://salon.com.feedsportal.com/c/35105/f/648624/index.rss"
  Setting.wall_street_journal_feed_urls = ["http://online.wsj.com/xml/rss/3_7041.xml", "http://online.wsj.com/xml/rss/3_7085.xml", "http://online.wsj.com/xml/rss/3_7014.xml", "http://online.wsj.com/xml/rss/3_7031.xml", "http://online.wsj.com/xml/rss/3_7455.xml", "http://online.wsj.com/xml/rss/3_7201.xml"]
  Setting.politico_feed_url = "http://www.politico.com/rss/politicopicks.xml"
  Setting.economist_feed_urls = ["http://www.economist.com/topics/banking/index.xml", "http://www.economist.com/topics/biotechnology/index.xml", "http://www.economist.com/topics/chinese-economy/index.xml", "http://www.economist.com/topics/computer-technology/index.xml", "http://www.economist.com/topics/corporate-governance/index.xml", "http://www.economist.com/topics/economics/index.xml", "http://www.economist.com/topics/environmental-problems-and-protection/index.xml", "http://www.economist.com/topics/european-union/index.xml", "http://www.economist.com/blogs/americasview/index.xml", "http://www.economist.com/blogs/analects/index.xml", "http://www.economist.com/blogs/babbage/index.xml", "http://www.economist.com/blogs/banyan/index.xml", "http://www.economist.com/blogs/baobab/index.xml", "http://www.economist.com/blogs/blighty/index.xml", "http://www.economist.com/blogs/clausewitz/index.xml", "http://www.economist.com/blogs/democracyinamerica/index.xml", "http://www.economist.com/blogs/feastandfamine/index.xml", "http://www.economist.com/blogs/freeexchange/index.xml", "http://wcom/blogs/gametheory/index.xml", "http://www.economist.com/blogs/globalleadership/index.xml", "http://www.economist.com/blogs/graphicdetail/index.xml", "http://www.economist.com/blogs/gulliver/index.xml", "http://www.economist.com/blogs/leviathan/index.xml", "http://www.economist.com/blogs/multimedia/index.xml", "http://www.economist.com/blogs/prospero/index.xml"]
  Setting.slate_feed_url = "http://feeds.slate.com/slate"
  Setting.foreign_affairs_feed_url = "http://www.foreignaffairs.com/rss.xml"
  Setting.new_yorker_feed_url = "http://www.newyorker.com/services/mrss/feeds/everything.xml"
  Cache.ensure_index([[:resource, 1], [:url, 1]])
  Cache.ensure_index(:resource)
  Cache.ensure_index(:_rand)
  Cache.ensure_index([[:resource, 1], [:_rand, 1]])

  AccountDatapoint.ensure_index([[:account_id, 1], [:provenance, 1]])
  Article.ensure_index(:url)
  Article.ensure_index(:created_at)
  Article.ensure_index(:published_at)
  Article.ensure_index(:publisher_code)
  ArticleDatapoint.ensure_index([[:article_id, 1], [:provenance, 1]])

  Score.ensure_index([[:ego_id, 1]])
  Score.ensure_index([[:ego_id, 1], [:provenance, 1]])
  Score.ensure_index([[:article_id, 1], [:ego_id, 1], [:provenance, 1]], :unique => true)
  Score.ensure_index([[:article_id, 1], [:provenance, 1], [:value, 1]])
  Score.ensure_index([[:article_id, 1], [:provenance, 1], [:value, 1], [:article_created_at, 1]])
  Score.ensure_index([[:article_id, 1], [:ego_id, 1], [:value, -1]])
  
  Provider::Twitter::User.ensure_index([[:account_id, 1], [:twitter_id, 1]], :unique => true)
  Provider::Twitter::Tweet.ensure_index([[:account_id, 1], [:twitter_id, 1]], :unique => true)
  Provider::Twitter::Relationship.ensure_index([[:account_id, 1], [:next_cursor, 1], [:direction, 1]], :unique => true)
end


desc "Blast the Database"
task :blow_out do
  [Account, Article, Author, Ego, Score, Topic, URLTitle].collect(&:collection).collect(&:drop)
end

desc "Re run scores"
task :rerun do
  Score.collection.drop
  offset = 0
  limit = 100
  articles = Article.limit(limit).offset(offset).to_a;false
  while !articles.empty?
    print "."
    articles.each do |article|
      RankURL.perform_async(article.url)
    end
    offset += limit
    articles = Article.limit(limit).offset(offset).to_a;false
  end
end