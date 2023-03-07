namespace :feed do
  desc 'fetch and update items from all feeds'
  task synchronize: :environment do
    Feed.to_synchronize.find_each do |feed|
      feed.synchronize!
    end
  end

  desc 'fetch and update items from a specific feed'
  task :synchronize_from_id, [:id] => :environment do |_t, args|
    feed = Feed.find(args[:id])
    feed.synchronize!
  end

  desc 'fetch and store items from all feeds'
  task store: :environment do
    Feed.find_each do |feed|
      feed.store!
    end
  end

  desc 'fetch and store items from a specific feed'
  task :store_from_id, [:id] => :environment do |_t, args|
    feed = Feed.find(args[:id])
    feed.store!
  end
end
