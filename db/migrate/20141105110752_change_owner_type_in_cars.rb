class ChangeOwnerTypeInCars < ActiveRecord::Migration
  def change
    remove_column :cars, :owner_id
    add_column :cars, :owner_id, :integer
  end
end
