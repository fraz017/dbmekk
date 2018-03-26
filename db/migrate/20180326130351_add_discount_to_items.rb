class AddDiscountToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :discount, :float
  end
end
