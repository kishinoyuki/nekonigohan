class Post < ApplicationRecord

    belongs_to :user
    belongs_to :item
    has_many :post_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :notifications, as: :notifiable, dependent: :destroy

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
    
  def self.price_range(params_min_price, params_max_price)
    includes(:item).where(items: { price: params_min_price..params_max_price })
  end
   
  def self.posts_by_params_order(params_order)
   case params_order
   when "評価が低い投稿から"
    self.custom_order_scope('star', 'ASC')
   when "評価が高い投稿から"
    self.custom_order_scope('star', 'DESC')
   when "投稿日時が新しい投稿から"
    self.custom_order_scope('posts.created_at', 'DESC')
   when "価格が安い商品から"
    self.includes(:item).custom_order_scope('items.price', 'ASC')
   when "価格が高い商品から"
    self.includes(:item).custom_order_scope('items.price', 'DESC')
   end
  end
  
  def self.combined_price_range_and_order(params_min_price, params_max_price, params_order)
   posts = self
   
   posts = posts.price_range(params_min_price, params_max_price) if params_min_price.present? && params_max_price.present?
   posts = posts.posts_by_params_order(params_order) if params_order.present?
   
   posts
  end
  
   after_create do
    user.followeds.each do |followed|
     notifications.create(user_id: followed.id)
    end
   end
   
end
