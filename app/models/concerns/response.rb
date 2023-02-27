# frozen_string_literal: true

module Response
  def json_success_response(object = {})
    render json: object, status: :ok
  end

  def json_response_with_serializer(object, status = :ok)
    serializer = if object.respond_to?(:each)
                   "#{object.klass.name}Serializer"
                 else
                   "#{object.class.name}Serializer"
                 end

    render json: Object.const_get(serializer).new(object), status:
  end

  def json_response_with_custom_serializer(object, serializer, status = :ok)
    render json: Object.const_get(serializer).new(object), status:
  end

  def json_error_response(error_type, error_message, status)
    render json: { error_type:, error_message: }, status:
  end
end
