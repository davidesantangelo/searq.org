# frozen_string_literal: true

class FlowsController < ApplicationController
  before_action :set_flow, only: [:show]

  def show
    respond_to do |format|
      format.html do
        render :show
      end
      format.json do
        render json: @flow.items
      end
    end
  end

  def create
    @flow = Flow.new(flow_params)

    if @flow.save
      flash[:notice] = 'Flow was successfully created.'
      redirect_to @flow
    else
      flash[:error] = 'Flow could not be created.'
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_flow
    @flow = Flow.find(params[:id])
  end

  def flow_params
    params.require(:flow).permit(:query)
  end
end
