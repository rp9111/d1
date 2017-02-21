class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :page
  belongs_to :page
  belongs_to :in_response_to, class_name: 'Comment', foreign_key: 'parent_id'
  has_many :comments, class_name: 'Comment', foreign_key: 'parent_id'
end
