class Tag < ApplicationRecord
 has_many :posts, dependent: :destroy
 validates :content, presence: true
end
