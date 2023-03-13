# frozen_string_literal: true

every 4.hours do
  rake 'feed:synchronize'
end
