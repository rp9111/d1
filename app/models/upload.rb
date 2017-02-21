class Upload < ApplicationRecord
  belongs_to :user
  belongs_to :page

  mount_uploader :attachment, ImageUploader

  def self.abandoned
    where('created_at > ?', 1.day.ago).
    where('page_id').nil?
  end
end
