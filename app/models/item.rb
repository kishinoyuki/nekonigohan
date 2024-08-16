class Item < ApplicationRecord
    belongs_to :post
 def post_id=(id)
    self.post = Post.find_by(id: id)
 end
    belongs_to :genre
    belongs_to :donation_destination
end
