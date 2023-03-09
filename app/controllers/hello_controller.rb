# frozen_string_literal: true

class HelloController < ApplicationController
  def index
    @token = cookies[:token].presence || generate_token
    @url = "#{request.base_url}/api"
    @q = %w[
      ruby
      rails
    ].sample
    @code = "curl -G -H \"Authorization: Token #{@token}\" #{@url}/search.json -d \"q=#{@q}\""
    @feeds_count = Feed.count
  end

  def download
    respond_to do |format|
      format.csv do
        send_data Feed.to_csv, filename: "feeds-#{Time.zone.now.to_date}.csv"
      end
    end
  end

  private

  def generate_token
    token = Token.create!
    cookies[:token] = { value: token.key, expires: token.expires_at }
    cookies[:token]
  end
end
