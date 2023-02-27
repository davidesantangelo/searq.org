# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_error_response('RecordNotFound', e.message, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_error_response('RecordInvalid', e.message, :unprocessable_entity)
    end

    rescue_from Pagy::OverflowError do |e|
      json_error_response('Overflow Error', e.message, :unprocessable_entity)
    end

    rescue_from ArgumentError do |e|
      json_error_response('ArgumentError', e.message, :unprocessable_entity)
    end

    rescue_from ActionController::ParameterMissing do |e|
      json_error_response('ParameterMissing', e.message, :unprocessable_entity)
    end
    
    rescue_from ActionController::RoutingError do |e|
      json_error_response('RoutingError', e.message, :not_found)
    end

    # MeiliSearch

    rescue_from MeiliSearch::CommunicationError do |e|
      json_error_response('CommunicationError', 'An error occurred while trying to communicate with Search API', :internal_server_error)
                          
    end

    rescue_from MeiliSearch::ApiError do |e|
      json_error_response('ApiError', 'An error occurred while trying to communicate with Search API', :internal_server_error)
    end

    rescue_from MeiliSearch::TimeoutError do |e|
      json_error_response('TimeoutError',
                          'An error occurred while trying to communicate with Search API. The request timed out',
                          :internal_server_error)
    end

    # Feedjira

    rescue_from Feedjira::NoParserAvailable do |_e|
      json_error_response('NoParserAvailable', 'An error occurred while trying to parse the feed URL',
                          :internal_server_error)
    end
  end
end
