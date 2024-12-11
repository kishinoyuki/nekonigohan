class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :comment, presence: true
  scope :custom_order_scope, -> (column, order) { order("#{column} #{order}") }
end
