class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :title
      t.text :body
      t.integer :star, null: false
      t.string :tag
      t.boolean :private, default: false, null: false

      t.timestamps
    end
  end
end
