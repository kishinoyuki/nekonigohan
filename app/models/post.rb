class Post < ApplicationRecord
    has_one_attached :image
    enum review: {yes_and_no: 0, dissatisfied: 1, rather_dissatisfied: 2, rather_satisfied: 3, satisfied: 4}
    
    belongs_to :user
    has_many :items, dependent: :destroy
    accepts_nested_attributes_for :items, allow_destroy: true
end
