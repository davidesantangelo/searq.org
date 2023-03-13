# frozen_string_literal: true

class FlowsController < ApplicationController
  before_action :set_flow, only: [:show]

  def new; end

  def show
    respond_to do |format|
      format.html do
        render :show
      end
      format.json do
        render json: items
      end
    end
  end

  def create
    @flow = Flow.new(flow_params)

    if @flow.save
      redirect_to @flow
    else
      render :index
    end
  end

  private

  def items
    Item.search(@flow.query, options)
  end

  def options
    {
      limit: 1000,
      offset: 0,
      sort: ['published_at:desc']
    }
  end

  def set_flow
    @flow = Flow.find(params[:id])
  end

  def flow_params
    params.require(:flow).permit(:query)
  end
end
