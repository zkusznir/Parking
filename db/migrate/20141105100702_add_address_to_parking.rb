class AddAddressToParking < ActiveRecord::Migration
  def change
  	add_column :parkings, :address_id, :integer
  	add_column :parkings, :owner_id, :integer
  end
end
