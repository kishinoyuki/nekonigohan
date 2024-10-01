class Post < ApplicationRecord
    enum review: {yes_and_no: 0, dissatisfied: 1, rather_dissatisfied: 2, rather_satisfied: 3, satisfied: 4}
    
   def self.review_options
    reviews.keys.map { |key| [I18n.t("enums.post.review.#{key}"), key] }
   end
   
    belongs_to :user
    belongs_to :item
    has_many :post_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy

    validates :title, presence: true
    validates :body, presence: true
    validates :review, presence: true
    
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
