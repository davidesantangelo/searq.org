# frozen_string_literal: true

every 1.day, at: '1:00 am' do
  rake 'feed:synchronize'
end
