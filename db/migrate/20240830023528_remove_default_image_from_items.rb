class RemoveDefaultImageFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :default_image, :string
    remove_column :items, :blob, :string
  end
end
