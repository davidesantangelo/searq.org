# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::FeedsController, type: :controller do
  let(:feeds) { create_list(:feed, 3) }
  let(:token) { create(:token) }

  before do
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(token.key)
  end

  describe 'GET #index' do
    before do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: feeds.first.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    before do
      post :create, params: { url: 'https://rubyonrails.org/feed.xml' }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #tasks' do
    before do
      get :tasks, params: { id: feeds.first.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
