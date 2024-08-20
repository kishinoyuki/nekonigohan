class AddItemIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :item_id, :integer
  end
end
