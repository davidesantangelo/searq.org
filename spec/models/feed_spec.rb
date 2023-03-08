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

    describe '#synchronize!' do
      it 'creates a new task' do
        expect { feed.synchronize! }.to change { Task.count }.by(1)
      end
    end
  end

  describe 'class methods' do
    describe '.to_csv' do
      let!(:feeds) { create_list(:feed, 3) }

      it 'returns a CSV string' do
        expect(Feed.to_csv).to be_a(String)
      end
    end

    describe '.to_synchronize' do
      let!(:feed) { create(:feed, synchronized_at: 1.day.ago) }

      it 'returns feeds to synchronize' do
        expect(Feed.to_synchronize).to include(feed)
      end
    end
  end
end
