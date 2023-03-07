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
end
