class Subscription < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  belongs_to :area
  
  liquid_methods :active, :expired, :create_url, :renew_url, :cancel_url

  def expired?
    expires_at.nil? || expires_at < Time.zone.now
  end
  
  def expired
    expired? && active
  end
  
  def active
    !new_record?
  end
  
  def create_url
    new_subscription_path(area.id) if area
  end
  
  def renew_url
    edit_subscription_path(area.id) if area
  end
  
  def cancel_url
    subscription_path(self.id, method: delete) if user && area && !new_record?
  end
  
end
