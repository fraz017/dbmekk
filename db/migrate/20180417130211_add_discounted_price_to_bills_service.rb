class AddDiscountedPriceToBillsService < ActiveRecord::Migration[5.1]
  def change
    add_column :bills_services, :discounted_price, :float
  end
end
