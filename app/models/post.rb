class Post < ApplicationRecord

    belongs_to :user
    belongs_to :item
    has_many :post_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy

    validates :title, presence: true
    validates :body, presence: true
    validates :star, presence: true
    validates :tag, presence: true
    has_one_attached :image
    
    scope :public_posts, -> {where(private: false)}
    scope :custom_order_scope, -> (column, order) {order("#{column} #{order}")}
    
    def get_image(width, height)
     unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
     end
     image.variant(resize_to_limit: [width, height]).processed
    end
    
    def favorited_by?(user)
     favorites.exists?(user_id: user.id)
    end
    
    
  def self.posts_by_price_pulldown_search(params_search)
   case params_search
   when "~1000円"
    self.includes(:item).where(items: {price: ..1000})
   when "1000~3000円"
    self.includes(:item).where(items: {price: 1000..3000})
   when "3000~5000円"
    self.includes(:item).where(items: {price: 3000..5000})
   when "5000~10000円"
    self.includes(:item).where(items: {price: 5000..10000})
   when "10000円~"
    self.includes(:item).where(items: {price: 10000..})
   end
  end
    
  def self.posts_by_params_order(params_order)
   case params_order
   when "評価が低い投稿から"
    self.custom_order_scope('star', 'ASC')
   when "評価が高い投稿から"
    #byebug
    self.custom_order_scope('star', 'DESC')
   when "投稿日時が新しい投稿から"
    self.custom_order_scope('created_at', 'DESC')
   when "価格が安い商品から"
    self.includes(:item).custom_order_scope('items.price', 'ASC')
   when "価格が高い商品から"
    self.includes(:item).custom_order_scope('items.price', 'DESC')
   end
  end
  
  def self.combined_posts_search_and_order(params_search, params_order)
   self.posts_by_price_pulldown_search(params_search).posts_by_params_order(params_order)
  end
end
