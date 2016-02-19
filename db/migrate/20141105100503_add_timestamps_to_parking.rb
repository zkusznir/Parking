class AddTimestampsToParking < ActiveRecord::Migration
  def change
  	add_column :parkings, :created_at, :datetime
    add_column :parkings, :updated_at, :datetime
  end
end
