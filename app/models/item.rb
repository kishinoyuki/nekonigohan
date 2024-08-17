class Item < ApplicationRecord
    belongs_to :post
 def post_id=(id)
    self.post = Post.find_by(id: id)
 end
    belongs_to :genre
    belongs_to :donation_destination
    
    def get_image
     unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
     end
     image
    end
end
