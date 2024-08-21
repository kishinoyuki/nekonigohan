class AddLocationToDonationDestinations < ActiveRecord::Migration[6.1]
  def change
    add_column :donation_destinations, :location, :integer
  end
end
