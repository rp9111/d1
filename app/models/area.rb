class Area < ApplicationRecord
  has_many   :pages, dependent: :destroy
  has_many   :subscriptions, dependent: :destroy
  belongs_to :theme

  include Impressive

  validates  :name, presence: true
  validates  :label, presence: { if: 'navigation? || footer?' }
  validates  :theme_id, presence: true
  
  delegate :style, :behavior, :structure, to: :theme

  liquid_methods :contents, :name, :title, :pages, :pay_wall, :sku_ids
  
  default_scope { order('position') } 

  attr_accessor :skus
  
  def self.reorder(ids)
    index = 0
    ids.each do |id|
      Area.find(id).update_column(:position, index)
      index += 1
    end
  end
  
  def contents
    pages.to_a
  end
  
  def pay_wall
    paid
  end

  def skus
    sku_ids.to_s.split
  end

  def skus=(ids)
    self.sku_ids = ids.to_a.join(' ')
  end
  
  def add_sku(other_sku)
    self.skus = skus + [other_sku]
  end

  def has_sku(other_sku)
    skus.to_a.include? other_sku
  end

  def has_matching_sku(other_skus)
    (skus.to_a & other_skus.to_a).any?
  end

  Area::LAYOUTS = [
    ['Slideshow', 'carousel', 'Slidehow is a fullscreen display of the cover images collected from the Pages in this Area. It is suitable for home pages and product displays, etc.'],
    ['Forum', 'threaded', 'Forum is good for bulletin boards, support forums, and FAQs. The titles of the Pages become the topics and visitors will be allowed to comment on them.'],
    ['Blog', 'stream', 'Blog simply displays one Page after the other.'],
    ['Parallax', 'parallax', 'Parallax is similar to Blog but adds visual interest to the banner images by scrolling them at a different speed than the text.'],
    ['Single page', 'single', 'Single displays only one page (the last page) added to this Area. It is suitable for static content such at Terms & Conditions, Privacy statements, etc.']
  ].freeze
end
