class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :title
      t.integer :review
      t.text :body
      t.integer :star, null: false

      t.timestamps
    end
  end
end
