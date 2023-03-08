# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  include ActionView::Helpers::SanitizeHelper

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:external_id) }
  end

  describe 'associations' do
    it { should belong_to(:feed) }
  end

  describe '#text' do
    let(:item) { create(:item) }

    it 'returns the text' do
      expect(item.text).to eq(strip_tags(item.body.presence || item.title).to_s.squish)
    end
  end

  describe '#published_at_timestamp' do
    let(:item) { create(:item) }

    it 'returns the timestamp' do
      expect(item.published_at_timestamp).to eq(item.published_at.to_i)
    end
  end
end
