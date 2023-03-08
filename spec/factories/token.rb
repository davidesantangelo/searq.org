# frozen_string_literal: true

FactoryBot.define do
  factory :token do
    key { SecureRandom.uuid }
    active { true }
    expires_at { Time.now + 1.day }
  end
end
