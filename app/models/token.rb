# frozen_string_literal: true

class Token < ApplicationRecord
  has_secure_token :key, length: 36

  # scopes
  scope :active, -> { where(active: true).where('expires_at IS NULL OR expires_at >= ?', Time.current) }
  scope :expired, -> { where.not(expires_at: nil).where('expires_at < ?', Time.current) }
  scope :permanent, -> { where(expires_at: nil) }

  # callbacks
  before_create :set_expires_at

  def permanent?
    expires_at.nil?
  end

  def refresh!
    update!(active: true, expires_at: 1.day.from_now)
    self
  end

  private

  def set_expires_at
    self.expires_at = 1.day.from_now if expires_at.nil?
  end
end
