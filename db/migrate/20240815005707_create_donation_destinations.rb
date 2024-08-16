class CreateDonationDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :donation_destinations do |t|
      t.string :name
      t.timestamps
    end
  end
end
