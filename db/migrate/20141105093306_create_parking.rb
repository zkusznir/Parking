class CreateParking < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.integer :places
      t.string :kind
      t.decimal :hour_price
      t.decimal :day_price
    end
  end
end
