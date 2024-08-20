class Post < ApplicationRecord
    enum review: {yes_and_no: 0, dissatisfied: 1, rather_dissatisfied: 2, rather_satisfied: 3, satisfied: 4}
    
    belongs_to :user
    belongs_to :item
end
