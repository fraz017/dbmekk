class AddDiscountedNetToBillsService < ActiveRecord::Migration[5.1]
  def change
    add_column :bills_services, :discounted_net, :float
  end
end
