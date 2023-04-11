# frozen_string_literal: true

class ErrorsController < ApplicationController
  layout 'error'

  def show
    render code, status: code
  end

  protected

  def code
    params[:code] || 500
  end
end
