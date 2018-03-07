class CreateBills < ActiveRecord::Migration[5.1]
  def change
    create_table :bills do |t|
      t.float :price
      t.integer :event_id

      t.timestamps
    end
  end
end
