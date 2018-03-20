class AddDiscountToBillsServices < ActiveRecord::Migration[5.1]
  def change
    add_column :bills_services, :discount, :float
  end
end
