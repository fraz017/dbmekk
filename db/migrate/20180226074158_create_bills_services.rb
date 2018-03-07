class CreateBillsServices < ActiveRecord::Migration[5.1]
  def change
    create_table :bills_services do |t|
      t.integer :service_id
      t.integer :bill_id

      t.timestamps
    end
  end
end
