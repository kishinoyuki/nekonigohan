class Item < ApplicationRecord
    belongs_to :post
    belongs_to :genre
    belongs_to :donation_destination
    
    has_one_attached :image
    
    def get_image
     unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
     end
     image.variant(resize_to_limit: [width, height]).proceed
    end
end
