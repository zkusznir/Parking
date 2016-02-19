class CreateAccount < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email
      t.integer :person_id

      t.timestamps
    end
  end
end
