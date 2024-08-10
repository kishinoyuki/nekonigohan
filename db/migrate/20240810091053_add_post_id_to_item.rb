class AddPostIdToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :post_id, :integer
  end
end
