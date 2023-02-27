# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @url = request.original_url
  end
end
