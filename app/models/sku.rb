class Sku < ApplicationRecord
  include Rails.application.routes.url_helpers
  validates :name, uniqueness: true, presence: true
  validates :plan_id, uniqueness: true, presence: true
  
  liquid_methods :name, :plan_id, :price, :interval, :description, :new_url, :hidden?, :subscription?, :onetime?
  
  def price=(n)
    self.amount = n.to_i * 100
  end

  def price
    amount / 100.0
  end
  
  def new_url
    new_subscription_path plan_id: plan_id
  end

  def subscription?
    interval != 'lifetime'
  end

  def onetime?
    !subscription?
  end
  
  def hidden?
    false
  end

end
