# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user,
   password] == [Rails.application.credentials.sidekiq[:username], Rails.application.credentials.sidekiq[:password]]
end
