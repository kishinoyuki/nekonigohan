class User < ApplicationRecord
  def active_for_authentication?
   super && (is_active == true)
  end
  scope :active, -> { where(is_active: true) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  has_one_attached :profile_image
  validates :name, presence: true
  
 def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
 end
 
 GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE ?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE ?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE ?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE ?","%#{word}%")
    else
      @user = User.all
    end
  end
  
   def guest_user?
    email == "guest@example.com"
   end
  
end
