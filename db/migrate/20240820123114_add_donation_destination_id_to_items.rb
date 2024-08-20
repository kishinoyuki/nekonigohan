class AddDonationDestinationIdToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :donation_destination_id, :integer
  end
end
