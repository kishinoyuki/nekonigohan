class Item < ApplicationRecord
    has_many :posts, dependent: :destroy
    belongs_to :genre
    belongs_to :donation_destination
    
    validates :name, presence: true
    validates :genre_id, presence: true
end
