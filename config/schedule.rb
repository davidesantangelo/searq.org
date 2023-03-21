# frozen_string_literal: true

every 4.hours do
  runner "Feed.to_synchronize.find_each(&:synchronize!)"
end
