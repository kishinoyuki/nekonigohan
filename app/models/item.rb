class Item < ApplicationRecord
    has_many :posts, dependent: :destroy
    belongs_to :genre
    belongs_to :donation_destination
    
    validates :name, presence: true
    validates :genre_id, presence: true
    validates :price, presence: true
    
    scope :price_range, -> (min_price, max_price) {where(price: min_price..max_price)}
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
   
   def self.items_by_genre_search(params_search)
    case params_search
    when "食品"
     self.where(genre_id: 1)
    when "化粧品"
     self.where(genre_id: 2)
    when "キッチン用品"
     self.where(genre_id: 3)
    when "インテリア"
     self.where(genre_id: 4)
    when "日用雑貨"
     self.where(genre_id: 5)
    when "ペット用品"
     self.where(genre_id: 6)
    end
   end
   
   def self.items_by_params_order(params_order)
    case params_order
    when "価格が安い商品から"
     self.custom_order_scope('price', 'ASC')
    when "価格が高い商品から"
     self.custom_order_scope('price', 'DESC')
    when "評価が低い商品から"
     self.average_rating('ASC')
    when "評価が高い商品から"
     self.average_rating('DESC')
    end
   end
   
   def self.combined_items_genre_search_and_order(params_search, params_order)
    self.items_by_genre_search(params_search).items_by_params_order(params_order)
   end
   
   def self.combined_items_genre_search_and_price_range(params_search, params_min_price, params_max_price)
    self.items_by_genre_search(params_search).price_range(params_min_price, params_max_price)
   end
   
   def self.combined_items_price_range_and_order(params_min_price, params_max_price, params_order)
    self.price_range(params_min_price, params_max_price).items_by_params_order(params_order)
   end
   
   def self.combined_items_genre_search_and_price_range_and_order(params_search, params_min_price, params_max_price, params_order)
    self.items_by_genre_search(params_search).price_range(params_min_price, params_max_price).items_by_params_order(params_order)
   end
end