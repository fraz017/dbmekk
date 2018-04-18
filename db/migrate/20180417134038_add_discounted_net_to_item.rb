class AddDiscountedNetToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :discounted_net, :float
  end
end
