# frozen_string_literal: true

class Flow < ApplicationRecord
  # validations
  validates :query, presence: true

  def items
    Item.search(query, options)
  end

  private

  def options
    {
      limit: 1000,
      offset: 0,
      sort: ['published_at:desc']
    }
  end
end
