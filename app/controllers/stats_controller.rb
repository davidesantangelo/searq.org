# frozen_string_literal: true

class StatsController < ApplicationController
  def index
    @feeds_count = Feed.count
    @items_count = Feed.sum(:items_count)
    @tokens_count = Token.count
  end
end
