# frozen_string_literal: true

class TokenSerializer
  include JSONAPI::Serializer
  attributes :key, :expires_at

  attribute :expires_at do |object|
    object.expires_at.to_i
  end
end
