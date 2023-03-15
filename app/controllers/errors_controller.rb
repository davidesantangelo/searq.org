# frozen_string_literal: true

class ErrorsController < ApplicationController
  layout 'error'

  def show
    render status_code.to_s, status: status_code
  end

  protected

  def status_code
    params[:code] || 500
  end
end
