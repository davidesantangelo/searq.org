# frozen_string_literal: true

Feed.clear_index!
Item.clear_index!

FeedManager::Create.new(url: 'https://www.ruby-lang.org/en/feeds/news.rss').call
FeedManager::Create.new(url: 'https://www.anandtech.com/rss').call
FeedManager::Create.new(url: 'https://www.engadget.com/rss.xml').call
FeedManager::Create.new(url: 'https://www.theverge.com/rss/index.xml').call
FeedManager::Create.new(url: 'https://www.wired.com/feed/rss').call
FeedManager::Create.new(url: 'https://www.cnet.com/rss/news/').call

Feed.all.each(&:store!)
