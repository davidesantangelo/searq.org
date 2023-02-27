# frozen_string_literal: true

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :search, only: %i[index]

  root 'search#index'

  get '/api', to: 'api/base#info'

  namespace :api, defaults: { format: 'json' } do
    resources :feeds, except: %i[new edit destroy] do
      member do
        get :tasks
      end
      resources :items, only: %i[index show]
      collection do
        get :search
      end
    end

    resources :tokens, only: [:create] do
      collection do
        post :refresh
      end
    end

    resources :search, only: %i[index]
    resources :tasks, only: %i[index show]
  end
end
