class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :genre_id
      t.integer :donation_destination_id
      t.integer :price
      t.timestamps
    end
  end
end
