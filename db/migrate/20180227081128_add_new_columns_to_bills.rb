class AddNewColumnsToBills < ActiveRecord::Migration[5.1]
  def change
    add_column :bills, :grand_total, :float
    add_column :items, :grand_total, :float
    add_column :services, :grand_total, :float
    add_column :bills, :tax, :float, default: 25.0
    add_column :items, :tax, :float, default: 25.0
    add_column :services, :tax, :float, default: 25.0
  end
end
