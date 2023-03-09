# frozen_string_literal: true

class ExportsController < ApplicationController
  def download
    respond_to do |format|
      format.csv do
        send_data items.to_csv, filename: "items-#{Time.zone.now.to_date}.csv"
      end
      format.json do
        render json: items
      end
    end
  end

  private

  def items
    Item.where(id: Item.search(params[:query]).pluck(:id))
  end
end
