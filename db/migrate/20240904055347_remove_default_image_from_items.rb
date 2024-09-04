class RemoveDefaultImageFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :default_image, :blob
  end
end
