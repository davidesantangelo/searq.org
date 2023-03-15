# frozen_string_literal: true

class FlowSerializer
  include FastJsonapi::ObjectSerializer
  attributes :query, :created_at, :updated_at
end
