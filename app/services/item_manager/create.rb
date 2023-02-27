# frozen_string_literal: true

module ItemManager
  class Create < ApplicationService
    attr_reader :feed, :entry

    def initialize(feed:, entry:)
      @feed = feed
      @entry = entry
    end

    def call
      create_item
    end

    private

    def create_item
      item = Parse.new(feed:, entry:).call

      return nil unless item

      item.save!
    end
  end
end
