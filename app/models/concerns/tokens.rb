module Tokens
  extend ActiveSupport::Concern

  included do
    has_secure_token
    has_secure_token :reset_token
    has_secure_password validations: false
  end

  def reset!
    regenerate_reset_token
    update_attribute :reset_at, DateTime.now
    save
  end

  def confirm!
    update_attributes reset_token: nil, reset_at: nil, confirmed: true
  end
end
