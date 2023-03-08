# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::TokensController, type: :controller do
  let(:token) { create(:token) }

  describe 'POST #create' do
    before do
      post :create
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #refresh' do
    before do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(token.key)
      post :refresh
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
