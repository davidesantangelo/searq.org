# frozen_string_literal: true

class Flow < ApplicationRecord
  # validations
  validates :query, presence: true
end
