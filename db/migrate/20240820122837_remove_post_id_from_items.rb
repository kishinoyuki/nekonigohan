class RemovePostIdFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :post_id, :integer
  end
end
