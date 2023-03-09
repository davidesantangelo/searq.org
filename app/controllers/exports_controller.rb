# frozen_string_literal: true

class ExportsController < ApplicationController
  def download
    respond_to do |format|
      format.csv do
        send_data csv, filename: "items-#{Time.zone.now.to_date}.csv"
      end
      format.json do
        render json: items
      end
    end
  end

  private

  def items
    Item.search(params[:query])
  end

  def csv
    attributes = %w[feed_title feed_url title url categories published_at]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      items.each do |item|
        csv << attributes.map { |attr| item.send(attr) }
      end
    end
  end
end
