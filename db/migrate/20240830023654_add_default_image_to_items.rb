class AddDefaultImageToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :default_image, :blob, defalut: 'no_image.jpg'
  end
end
