# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feed, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:title) }
  end

  describe 'associations' do
    it { should have_many(:items) }
    it { should have_many(:tasks) }
  end

  describe 'methods' do
    let(:feed) { create(:feed) }

    describe '#store!' do
      it 'creates a new task' do
        expect { feed.store! }.to change { Task.count }.by(1)
      end
    end

    describe '#fetch!' do
      it 'creates a new task' do
        expect { feed.fetch! }.to change { Task.count }.by(1)
      end
    end
  end

  describe 'meilisearch' do
    let(:feed) { create(:feed) }
    let(:task) { create(:task, feed:) }

    before do
      FeedManager::Store.new(feed: task.feed).call
    end

    it 'search the feed' do
      expect(Feed.search(feed.title).first).to eq(feed)
    end
  end
end
