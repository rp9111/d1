class Promo < ApplicationRecord
  belongs_to :area
  belongs_to :course, class_name: 'Area', foreign_key: 'course_id'
  
  validates :name, presence: true
  validates :course, presence: true
  validates :stripe_coupon, presence: true
  
  def self.add_hit(promo_code)
    @promo = Promo.where(enabled: true).find_by_name promo_code
    @promo.add_hit if @promo
  end
  
  def self.add_conversion(promo_code)
    @promo = Promo.where(enabled: true).find_by_name promo_code
    @promo.add_conversion if @promo
  end
  
  def add_hit
    update hits: hits + 1
  end
  
  def add_conversion
    update conversions: conversions + 1
  end
  
  def rate
    hits > 0 ? (conversions / hits) : 0
  end
end
