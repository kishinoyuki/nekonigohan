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
end
