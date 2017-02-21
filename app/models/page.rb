class Page < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to  :area
  belongs_to  :user
  has_many    :comments, dependent: :destroy
  has_many    :uploads, dependent: :destroy

  include Impressive
  
  store_accessor :properties, :classes

  before_save :fix
  after_validation :set_cover
  validates :title, presence: true
  validates :content, presence: true
  
  liquid_methods :title, :content, :cover, :permalink, :properties, :published_at, :updated_at, :url, :next_page, :previous_page, :classes

  default_scope { order('position') } 

  def self.reorder(ids)
    _previous_id = _next_id = nil
    ids.each_with_index do |id, index|
      position = index + 1
      _next_id = ids[position + 1]
      Page.find(id).update_columns(position: position)
      _previous_id = id
    end
  end

  def set_cover
    return if cover.present?
    test = content.match("img\s.*src=['\"](.*?)['\"]")
    self.cover = test[1] if test.present?
  end

  def url
    page_url(area, position)
  end

  def next_page
    area.pages.find_by(position: position + 1)
  end

  def previous_page
    area.pages.find_by(position: position - 1)
  end

  def self.reorder(ids)
    index = 1
    ids.each do |id|
      Page.find(id).update_column(:position, index)
      index += 1
    end
  end
  
  private

  def fix
    strip_content
  end

  def strip_content
    content.strip!
  end

  def page_url(the_area = area, page_id = nil)
    path = root_url + area.name.parameterize('_')
    path += "?page=#{page_id.to_i}" if page_id
    path
  end

end
