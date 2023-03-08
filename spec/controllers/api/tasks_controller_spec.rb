# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::TasksController, type: :controller do
  let(:task) { create(:task) }
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
      get :show, params: { id: task.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
