class AddImageToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :image, :blob
  end
end
