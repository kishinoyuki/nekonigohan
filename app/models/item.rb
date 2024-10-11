class Item < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :item_tags
    has_many :tags, through: :item_tags
    belongs_to :genre
    belongs_to :donation_destination
    
    validates :name, presence: true
    validates :genre_id, presence: true
    
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