class Item < ApplicationRecord
    has_many :posts, dependent: :destroy
    belongs_to :genre
    belongs_to :donation_destination
    
    validates :name, presence: true
    validates :genre_id, presence: true
    validates :price, presence: true
    
    scope :custom_order_scope, -> (column, order) {order("#{column} #{order}")}
    scope :average_rating, -> (order = 'DESC') {
    joins(:posts).group('items.id').order("AVG(posts.star) #{order}")
    }

   def self.looks(search, word)
     if search == "perfect_match"
      @item = Item.where("name LIKE ?", "#{word}")
     elsif search == "forward_match"
      @item = Item.where("name LIKE ?","#{word}%")
     elsif search == "backward_match"
      @item = Item.where("name LIKE ?","%#{word}")
     elsif search == "partial_match"
      @item = Item.where("name LIKE ?","%#{word}%")
     else
      @item = Item.all
     end
   end
end