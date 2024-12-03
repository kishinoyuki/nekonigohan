class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :follower
      t.references :followed
      t.timestamps
      t.index [:follower_id, :followed_id], unique: true
    end
  end
end
