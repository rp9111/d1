class Theme < ApplicationRecord
  has_many :areas
  validates :name, presence: true

  def content
    "<script>#{behavior}</script>
    <style>#{style}</style>
    #{structure}"
  end
  
  def style
    super || ''
  end

  def behavior
    super || ''
  end

  def structure
    super || ''
  end

end
