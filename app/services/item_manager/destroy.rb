# frozen_string_literal: true

module ItemManager
  class Destroy < ApplicationService
    attr_reader :item

    def initialize(item:)
      @item = item
    end

    def call
      destroy_item
    end

    private

    def destroy_item
      item.remove_from_index!
      item.destroy!
    end
  end
end
