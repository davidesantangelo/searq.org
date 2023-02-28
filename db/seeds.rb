# frozen_string_literal: true

Feed.clear_index!
Item.clear_index!

feeds = [
  'https://www.ruby-lang.org/en/feeds/news.rss',
  'https://www.anandtech.com/rss',
  'https://www.engadget.com/rss.xml',
  'https://www.theverge.com/rss/index.xml',
  'https://www.wired.com/feed/rss',
  'https://www.cnet.com/rss/news/',
  'http://www.repubblica.it/rss/homepage/rss2.0.xml',
  'https://www.theguardian.com/uk/rss',
  'https://www.nytimes.com/svc/collections/v1/publish/https://www.nytimes.com/section/world/rss.xml',
  'https://www.bbc.com/news/world/rss.xml',
  'https://www.bbc.com/news/uk/rss.xml',
  'https://www.bbc.com/news/business/rss.xml',
  'https://www.bbc.com/news/technology/rss.xml',
  'https://www.bbc.com/news/science_and_environment/rss.xml',
  'https://www.bbc.com/news/health/rss.xml',
  'https://www.bbc.com/news/entertainment_and_arts/rss.xml',
  'https://www.bbc.com/news/politics/rss.xml',
  'https://www.bbc.com/news/education/rss.xml',
  'https://feeds.feedburner.com/hd-blog',
  'https://feeds.feedburner.com/techcrunch/',
  'https://feeds.feedburner.com/techcrunch/startups',
  'https://feeds.feedburner.com/techcrunch/gadgets',
  'https://feeds.feedburner.com/techcrunch/social',
  'https://feeds.feedburner.com/techcrunch/fundings-exits',
  'https://feeds.feedburner.com/techcrunch/enterprise',
  'https://feeds.feedburner.com/techcrunch/transportation',
  'https://feeds.feedburner.com/techcrunch/europe',
  'https://feeds.feedburner.com/techcrunch/asia',
]

feeds.each do |url|
  FeedManager::Create.new(url: url).call
end

Feed.all.each(&:store!)
